SMODS.BundlesOfFun = {}
if not BundlesOfFun then
    BundlesOfFun = {}
end

local function normalize_path(path)
    return path:gsub("\\", "/"):gsub("//+", "/"):gsub("/$", "")
end

local function load_directory(relative_path)
    local full_path = normalize_path(SMODS.current_mod.path .. "/" .. relative_path)
    local files = NFS.getDirectoryItemsInfo(full_path)
    for _, file in ipairs(files) do
        local file_path = full_path .. "/" .. file.name
        if file.type == "directory" then
            load_directory(relative_path .. "/" .. file.name)
        elseif file.name:sub(-4):lower() == ".lua" then
            local mod_relative_path = relative_path .. "/" .. file.name
            assert(SMODS.load_file(mod_relative_path))()
        end
    end
end

load_directory("lib")
load_directory("items")