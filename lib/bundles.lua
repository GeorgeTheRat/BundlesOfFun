-- use bundle == "bundle_name" to attach an object to a bundle
-- use bundle == { "bundle_name", { "bundle_dependency_1", "bundle_dependency_2", ... } } to have an object rely on other bundles to be visible

-- extract primary bundle and dependencies from bundle field
local function parse_bundle(bundle)
    if type(bundle) == "string" then
        return bundle, nil
    elseif type(bundle) == "table" then
        return bundle[1], bundle[2]
    end
    return nil, nil
end

-- check if bundle and its dependencies are enabled
local function check_bundle_enabled(primary, secondary)
    if not BundlesOfFun.config.bundles[primary] then
        return false
    end
    if secondary then
        for _, bundle_name in ipairs(secondary) do
            if not BundlesOfFun.config.bundles[bundle_name] then
                return false
            end
        end
    end
    return true
end

-- create function to hide item from collection when bundle disabled
local function get_bundle_no_collection(bundle)
    if bundle then
        local primary, secondary = parse_bundle(bundle)
        return function()
            return not check_bundle_enabled(primary, secondary)
        end
    end
end

-- prevent disabled bundle items from entering pools
local original_add_to_pool = SMODS.add_to_pool
SMODS.add_to_pool = function(prototype_obj, args)
    if prototype_obj.bundle then
        local primary, secondary = parse_bundle(prototype_obj.bundle)
        if not check_bundle_enabled(primary, secondary) then
            return false
        end
    end
    return original_add_to_pool(prototype_obj, args)
end

BundlesOfFun.Joker = SMODS.Joker:extend({
    inject = function(self)
        if self.bundle and not self.no_collection then
            self.no_collection = get_bundle_no_collection(self.bundle)
        end
        SMODS.Joker.inject(self)
    end
})

BundlesOfFun.Back = SMODS.Back:extend({
    inject = function(self)
        if self.bundle and not self.no_collection then
            self.no_collection = get_bundle_no_collection(self.bundle)
        end
        SMODS.Back.inject(self)
    end
})

BundlesOfFun.Consumable = SMODS.Consumable:extend({
    inject = function(self)
        if self.bundle and not self.no_collection then
            self.no_collection = get_bundle_no_collection(self.bundle)
        end
        SMODS.Consumable.inject(self)
    end
})

BundlesOfFun.Booster = SMODS.Booster:extend({
    inject = function(self)
        if self.bundle and not self.no_collection then
            self.no_collection = get_bundle_no_collection(self.bundle)
        end
        SMODS.Booster.inject(self)
    end
})

BundlesOfFun.Voucher = SMODS.Voucher:extend({
    inject = function(self)
        if self.bundle and not self.no_collection then
            self.no_collection = get_bundle_no_collection(self.bundle)
        end
        SMODS.Voucher.inject(self)
    end
})

-- Bundle-to-items map, lazily built on first toggle.
-- bundle_name -> { center_object, ... }
BundlesOfFun.bundle_items = nil

-- build mapping from all registered centers
function BundlesOfFun.ensure_bundle_map()
    if BundlesOfFun.bundle_items then return end
    BundlesOfFun.bundle_items = {}
    if not G.P_CENTERS then return end
    for key, center in pairs(G.P_CENTERS) do
        if center.bundle then
            local primary, secondary = parse_bundle(center.bundle)
            if primary then
                BundlesOfFun.bundle_items[primary] = BundlesOfFun.bundle_items[primary] or {}
                table.insert(BundlesOfFun.bundle_items[primary], center)
                if secondary then
                    for _, dep in ipairs(secondary) do
                        BundlesOfFun.bundle_items[dep] = BundlesOfFun.bundle_items[dep] or {}
                        table.insert(BundlesOfFun.bundle_items[dep], center)
                    end
                end
            end
        end
    end
end

-- add or remove item from pool based on enabled state
local function sync_pool(pool, center, enabled)
    if not pool then return end
    if enabled then
        local found = false
        for _, v in ipairs(pool) do
            if v.key == center.key then found = true; break end
        end
        if not found then
            table.insert(pool, center)
        end
    else
        for i = #pool, 1, -1 do
            if pool[i].key == center.key then
                table.remove(pool, i)
            end
        end
    end
end

-- update all pools for items in a bundle when toggled
function BundlesOfFun.sync_bundle(bundle_name)
    if not G.P_CENTER_POOLS then return end
    BundlesOfFun.ensure_bundle_map()
    local items = BundlesOfFun.bundle_items[bundle_name]
    if not items then return end
    for _, center in ipairs(items) do
        local primary, secondary = parse_bundle(center.bundle)
        local enabled = check_bundle_enabled(primary, secondary)
        sync_pool(G.P_CENTER_POOLS[center.set], center, enabled)
        if center.pools then
            for pool_key in pairs(center.pools) do
                sync_pool(G.P_CENTER_POOLS[pool_key], center, enabled)
            end
        end
    end
end

-- sync all bundles to current config state
function BundlesOfFun.sync_all_bundles()
    BundlesOfFun.ensure_bundle_map()
    if not BundlesOfFun.bundle_items then return end
    for bundle_name in pairs(BundlesOfFun.bundle_items) do
        BundlesOfFun.sync_bundle(bundle_name)
    end
end

-- recalculate collection tallies respecting bundle visibility
function BundlesOfFun.refresh_collection_ui()
    if not G.DISCOVER_TALLIES or not G.P_CENTERS then return end
    local set_to_tally = {
        Joker = "jokers",
        Voucher = "vouchers",
        Booster = "boosters",
        Edition = "editions",
        Back = "backs"
    }
    for _, v in pairs(G.P_CENTERS) do
        if not v.omit and type(v.no_collection) == "function" and not v.no_collection() then
            local tally_key = set_to_tally[v.set] or (v.consumeable and "consumeables")
            local tally = tally_key and G.DISCOVER_TALLIES[tally_key]
            if tally then
                tally.of = tally.of + 1
                if v.discovered then tally.tally = tally.tally + 1 end
                G.DISCOVER_TALLIES.total.of = G.DISCOVER_TALLIES.total.of + 1
                if v.discovered then G.DISCOVER_TALLIES.total.tally = G.DISCOVER_TALLIES.total.tally + 1 end
                if v.consumeable then
                    local sub = G.DISCOVER_TALLIES[v.set:lower().."s"]
                    if sub then
                        sub.of = sub.of + 1
                        if v.discovered then sub.tally = sub.tally + 1 end
                    end
                end
            end
        end
    end
    for _, entry in pairs(G.DISCOVER_TALLIES) do
        if type(entry) == "table" then
            entry.display = (entry.tally or 0).." / "..(entry.of or 0)
        end
    end
end

-- handle bundle toggle with pool sync and live update
function BundlesOfFun.on_bundle_toggle(bundle_name)
    BundlesOfFun.sync_bundle(bundle_name)
    if BundlesOfFun.tab_content_box and G.ACTIVE_MOD_UI then
        local tabs = G.ACTIVE_MOD_UI.extra_tabs and G.ACTIVE_MOD_UI.extra_tabs()
        if tabs then
            local active_idx = 1
            if BundlesOfFun.tab_content_box.parent and BundlesOfFun.tab_content_box.parent.children then
                for _, sibling in ipairs(BundlesOfFun.tab_content_box.parent.children) do
                    if sibling ~= BundlesOfFun.tab_content_box and sibling.children then
                        for _, btn in ipairs(sibling.children) do
                            if btn.config and btn.config.chosen then
                                active_idx = btn.config.tab_index or active_idx
                            end
                        end
                    end
                end
            end
            local tab_def = tabs[active_idx]
            if tab_def and tab_def.tab_definition_function then
                BundlesOfFun.tab_content_box.config.object = UIBox(tab_def.tab_definition_function())
                BundlesOfFun.tab_content_box:recalculate()
            end
        end
    end
end

-- refresh tallies when mod overlay closes
function BundlesOfFun.on_exit_mods()
    BundlesOfFun.refresh_collection_ui()
end

-- Replace the raw bundles config table with a proxy that fires on_bundle_toggle
-- whenever a value changes. This keeps the existing create_toggle UI working unchanged.
do
    local original = BundlesOfFun.config.bundles
    local proxy = {}
    for k, v in pairs(original) do
        proxy[k] = v
    end
    setmetatable(proxy, {
        __index = original,
        __newindex = function(t, k, v)
            original[k] = v
            rawset(t, k, v)
            if type(k) == "string" then
                BundlesOfFun.on_bundle_toggle(k)
            end
        end
    })
    BundlesOfFun.config.bundles = proxy
end

return true