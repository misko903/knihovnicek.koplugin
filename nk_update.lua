-- Self-update from the latest GitHub release (asset knihovnicek.koplugin.zip).
-- Everything except install() is plain Lua and covered by tests/run.lua.
local Http = require("nk_http")

local Update = {}

Update.API = "https://api.github.com/repos/misko903/neknihy/releases/latest"
Update.ASSET = "knihovnicek.koplugin.zip"

--- "v1.2.3" / "1.2" -> {1, 2, 3}; nil when there is no number in it.
function Update.parseVersion(s)
    if type(s) ~= "string" then
        return nil
    end
    local parts = {}
    for n in s:gsub("^%s*v", ""):gmatch("%d+") do
        parts[#parts + 1] = tonumber(n)
    end
    if #parts == 0 or not s:match("^%s*v?%d") then
        return nil
    end
    return parts
end

--- True when version `latest` is strictly newer than `current`.
function Update.isNewer(latest, current)
    local a, b = Update.parseVersion(latest), Update.parseVersion(current)
    if not a then
        return false
    end
    if not b then
        return true
    end
    for i = 1, math.max(#a, #b) do
        local x, y = a[i] or 0, b[i] or 0
        if x ~= y then
            return x > y
        end
    end
    return false
end

--- Decoded GitHub release -> {version, url, notes} or nil, error. `url` is
--- nil when the release has no plugin asset.
function Update.parseRelease(data)
    if type(data) ~= "table" or type(data.tag_name) ~= "string" then
        return nil, "invalid release"
    end
    local url
    for _i, asset in ipairs(data.assets or {}) do
        if asset.name == Update.ASSET then
            url = asset.browser_download_url
        end
    end
    return { version = (data.tag_name:gsub("^v", "")), url = url, notes = data.body }
end

--- Newest release (see parseRelease) or nil, error.
function Update.latest()
    local data, err = Http.json(nil, {
        url = Update.API,
        headers = { Accept = "application/vnd.github+json" },
        timeout = 15, total_timeout = 30,
    })
    if not data then
        return nil, err
    end
    return Update.parseRelease(data)
end

--- A path inside the zip is safe when it is relative and has no "..".
function Update.safePath(path)
    if path:sub(1, 1) == "/" or path:match("^%a:") or path:find("\\", 1, true) then
        return false
    end
    for part in path:gmatch("[^/]+") do
        if part == ".." then
            return false
        end
    end
    return true
end

--- Zip entry -> path relative to the plugin directory (the archive has a
--- "knihovnicek.koplugin/" top folder), or nil to skip it.
function Update.targetPath(entry)
    local rel = entry:gsub("^knihovnicek%.koplugin/", "")
    if rel == "" or rel:sub(-1) == "/" or not Update.safePath(rel) then
        return nil
    end
    -- never ship tests to the reader
    if rel:match("^tests/") then
        return nil
    end
    return rel
end

--- Download the zip and replace the plugin files in `plugin_dir`.
--- Returns true or nil, error. KOReader only (ffi/archiver, lfs).
function Update.install(url, plugin_dir)
    local lfs = require("libs/libkoreader-lfs")
    local Archiver = require("ffi/archiver")
    local zip_path = plugin_dir .. "/.update.zip"

    local fh, ferr = io.open(zip_path, "wb")
    if not fh then
        return nil, ferr
    end
    local r, err = Http.request(nil, {
        url = url, sink = Http.fileSink(fh), timeout = 30, total_timeout = 300,
    })
    pcall(fh.close, fh)
    if not r or r.code ~= 200 then
        os.remove(zip_path)
        return nil, err or ("HTTP " .. tostring(r and r.code))
    end

    local reader = Archiver.Reader:new()
    if not reader:open(zip_path) then
        os.remove(zip_path)
        return nil, "invalid archive"
    end
    -- read everything first so a broken archive leaves the plugin untouched
    local files = {}
    for entry in reader:iterate() do
        if entry.mode == "file" then
            local rel = Update.targetPath(entry.path)
            if rel then
                local content = reader:extractToMemory(entry.path)
                if not content then
                    reader:close()
                    os.remove(zip_path)
                    return nil, "extract failed: " .. entry.path
                end
                files[rel] = content
            end
        end
    end
    reader:close()
    os.remove(zip_path)
    if not files["main.lua"] or not files["_meta.lua"] then
        return nil, "invalid archive"
    end

    for rel, content in pairs(files) do
        local dir = plugin_dir
        for part in rel:gmatch("([^/]+)/") do
            dir = dir .. "/" .. part
            lfs.mkdir(dir)
        end
        local target = plugin_dir .. "/" .. rel
        local out, oerr = io.open(target .. ".new", "wb")
        if not out then
            return nil, oerr
        end
        out:write(content)
        out:close()
        os.remove(target)
        os.rename(target .. ".new", target)
    end
    return true
end

return Update
