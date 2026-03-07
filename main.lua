if not BundlesOfFun then BundlesOfFun = {} end
SMODS.BundlesOfFun = BundlesOfFun

BundlesOfFun.config = SMODS.current_mod.config or {}
BundlesOfFun.config.bundles = BundlesOfFun.config.bundles or {}

BundlesOfFun.mod_config = SMODS.current_mod.config

assert(SMODS.load_file("lib/badge.lua"))()
assert(SMODS.load_file("lib/balance.lua"))()
assert(SMODS.load_file("lib/compat.lua"))()
assert(SMODS.load_file("lib/hooks.lua"))()
assert(SMODS.load_file("lib/plural.lua"))()
assert(SMODS.load_file("lib/smods.lua"))()

-- function for nil checks on tables - just input a string like "card.ability.extra.whatever" and it'll split it up
function BundlesOfFun.nil_check(path)
    local result = ""
    local current = ""

    for part in path:gmatch("[^%.]+") do
        if current == "" then
            current = part
        else
            current = current .. "." .. part
        end

        if result == "" then
            result = current
        else
            result = result .. " and " .. current
        end
    end

    return result
end

local files = {
    appetizers = {
        list = {
			"dragonfruit",
            "blueberry",
            "grapes",
            "shrimp",
            "durian",
            "wonderous_bread",
            "jelly_beans",
            "apple",
            "apple_core",
            "tomato"
		}, directory = "items/appetizers/"
    },
    jesters = {
        list = {
            "hal",
            "henry",
            "tom",
            "barber",
            "ballbo",
            "rogue",
            "eddrick",
            "super",
            "eureka",
            "timmy",
            "gary",
            "golden_sun",
            "jack_frost",
            "jim",
            "gumphrey",
            "soothsayer",
            "polymath",
            "luminary",
            "furious",
            "larry",
            "phony",
            "frank",
            "crafted",
            "schlitzohr",
            "hotboxer"
        }, directory = "items/jesters/"
    },
    -- normalities = {
    --     list = {
            
    --     }, directory = "items/normalities/"
    -- },
    fables = {
        list = {
            "narr",
            "manqian",
            "turold",
            "taillefer",
            "dagonet"
        }, directory = "items/fables/"
    }
}

for _, category in ipairs({"appetizers", "jesters", "fables"}) do
	local set = files[category]
	for _, name in ipairs(set.list) do
		assert(SMODS.load_file(set.directory .. name .. ".lua"))()
	end
end

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