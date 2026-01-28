if not BundlesOfFun then BundlesOfFun = {} end
SMODS.BundlesOfFun = BundlesOfFun

BundlesOfFun.config = SMODS.current_mod.config or {}
BundlesOfFun.config.bundles = BundlesOfFun.config.bundles or {}

BundlesOfFun.mod_config = SMODS.current_mod.config

local function load_directory(relative_path)
    local full_path = SMODS.current_mod.path .. "/" .. relative_path
    if NFS.getInfo(full_path) and NFS.getInfo(full_path).type == "directory" then
        local files = NFS.getDirectoryItems(full_path)
        for _, file in ipairs(files) do
            local file_path = full_path .. "/" .. file
            if NFS.getInfo(file_path).type == "directory" then
                load_directory(relative_path .. "/" .. file)
            elseif file:sub(-4):lower() == ".lua" then
                local mod_relative_path = relative_path .. "/" .. file
                local success, result = pcall(function()
                    return SMODS.load_file(mod_relative_path)()
                end)
                if not success then
                    print("[Bundles of Fun] Error loading " .. mod_relative_path .. ": " .. tostring(result))
                end
            end
        end
    end
end

load_directory("lib")
load_directory("items")

function BundlesOfFun.is_item_enabled(item_key)
    if not item_key or type(item_key) ~= "string" then 
        return true 
    end
    
    BundlesOfFun.config = BundlesOfFun.config or {}
    BundlesOfFun.config.bundles = BundlesOfFun.config.bundles or {}
    
    local prefix = item_key:sub(1, 1)
    local category_map = {
        a = "appetizers",
        f = "fables",
        g = "geodes",
        j = "jesters",
        n = "normalities"
    }
    
    local category = category_map[prefix]
    if category then
        return BundlesOfFun.config.bundles[category] ~= false
    end
    
    return true
end

function BundlesOfFun.update_item_registry()
    for k, v in pairs(G.P_CARDS) do
        if v.set == "Joker" and v.key:sub(1, 1) == "j" then
            if not BundlesOfFun.is_item_enabled(v.key) then
                if not v.cry_disabled then
                    v:_disable({type = "config"})
                end
            else
                if v.cry_disabled and v.cry_disabled.type == "config" then
                    v:enable()
                end
            end
        end
    end
    
    for k, v in pairs(G.P_CENTER_POOLS.Consumeables) do
        local prefix = v.key:sub(1, 1)
        if not BundlesOfFun.is_item_enabled(v.key) then
            if not v.cry_disabled then
                v:_disable({type = "config"})
            end
        else
            if v.cry_disabled and v.cry_disabled.type == "config" then
                v:enable()
            end
        end
    end
end

if not SMODS.Center.enable then
    SMODS.Center.enable = function(self)
        if self.cry_disabled then
            self.cry_disabled = nil
            SMODS.insert_pool(G.P_CENTER_POOLS[self.set], self)
            G.P_CENTERS[self.key] = self
            for k, v in pairs(self.pools or {}) do
                SMODS.ObjectTypes[k]:inject_card(self)
            end
        end
    end

    SMODS.Center._disable = function(self, reason)
        if not self.cry_disabled then
            self.cry_disabled = reason or { type = "manual" }
            SMODS.remove_pool(G.P_CENTER_POOLS[self.set], self.key)
            for k, v in pairs(self.pools or {}) do
                SMODS.ObjectTypes[k]:delete_card(self)
            end
            G.P_CENTERS[self.key] = nil
        end
    end
end

local function create_bundles_config_tab()
    BundlesOfFun.config = BundlesOfFun.config or {}
    BundlesOfFun.config.bundles = BundlesOfFun.config.bundles or {}
    
    local categories = {
        { id = "appetizers", name = "Appetizers", color = G.C.RED },
        { id = "fables", name = "Fables", color = G.C.BLUE },
        { id = "geodes", name = "Geodes", color = G.C.PURPLE },
        { id = "jesters", name = "Jesters", color = G.C.ORANGE },
        { id = "normalities", name = "Normalities", color = G.C.GREY },
    }
    
    for _, category in ipairs(categories) do
        if BundlesOfFun.config.bundles[category.id] == nil then
            BundlesOfFun.config.bundles[category.id] = true
        end
    end
    
    local nodes = {}
    for _, category in ipairs(categories) do
        local toggle = create_toggle({
            active_colour = category.color,
            label = category.name,
            ref_table = BundlesOfFun.config.bundles,
            ref_value = category.id,
            func = function()
                if SMODS.current_mod and SMODS.current_mod.save then
                    SMODS.current_mod:save()
                    BundlesOfFun.update_item_registry()
                end
            end
        })
        
        table.insert(nodes, {
            n = G.UIT.R,
            config = { align = "cm", padding = 0.05 },
            nodes = { toggle }
        })
    end
    
    return {
        n = G.UIT.ROOT,
        config = {
            emboss = 0.05,
            minh = 6,
            r = 0.1,
            minw = 10,
            align = "cm",
            padding = 0.2,
            colour = G.C.BLACK
        },
        nodes = nodes
    }
end

BundlesOfFun.create_config_tab = create_bundles_config_tab
SMODS.current_mod.config_tab = create_bundles_config_tab
BundlesOfFun.update_item_registry()
