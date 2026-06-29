-- use bundle == "bundle_name" to attach an object to a bundle
-- use bundle == { "bundle_name", { "bundle_dependency_1", "bundle_dependency_2", ... } } to have an object rely on other bundles to be visible

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

local function get_bundle_no_collection(bundle)
    if bundle then
        local primary, secondary
        if type(bundle) == "string" then
            primary = bundle
        elseif type(bundle) == "table" then
            primary = bundle[1]
            secondary = bundle[2]
        end
        return function()
            return not check_bundle_enabled(primary, secondary)
        end
    end
end

local original_add_to_pool = SMODS.add_to_pool
SMODS.add_to_pool = function(prototype_obj, args)
    if prototype_obj.bundle then
        local primary, secondary
        if type(prototype_obj.bundle) == "string" then
            primary = prototype_obj.bundle
        elseif type(prototype_obj.bundle) == "table" then
            primary = prototype_obj.bundle[1]
            secondary = prototype_obj.bundle[2]
        end
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

BundlesOfFun.Consumable = SMODS.Consumable:extend({
    inject = function(self)
        if self.bundle and not self.no_collection then
            self.no_collection = get_bundle_no_collection(self.bundle)
        end
        SMODS.Consumable.inject(self)
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

BundlesOfFun.Booster = SMODS.Booster:extend({
    inject = function(self)
        if self.bundle and not self.no_collection then
            self.no_collection = get_bundle_no_collection(self.bundle)
        end
        SMODS.Booster.inject(self)
    end
})

-- Bundle-to-items map, lazily built on first toggle.
-- bundle_name -> { center_object, ... }
BundlesOfFun.bundle_items = nil

function BundlesOfFun.ensure_bundle_map()
    if BundlesOfFun.bundle_items then return end
    BundlesOfFun.bundle_items = {}
    if not G.P_CENTERS then return end
    for key, center in pairs(G.P_CENTERS) do
        if center.bundle then
            local primary = type(center.bundle) == "string" and center.bundle or center.bundle[1]
            BundlesOfFun.bundle_items[primary] = BundlesOfFun.bundle_items[primary] or {}
            table.insert(BundlesOfFun.bundle_items[primary], center)
            -- Also track secondary dependencies so we can sync them too
            if type(center.bundle) == "table" and center.bundle[2] then
                for _, dep in ipairs(center.bundle[2]) do
                    BundlesOfFun.bundle_items[dep] = BundlesOfFun.bundle_items[dep] or {}
                    table.insert(BundlesOfFun.bundle_items[dep], center)
                end
            end
        end
    end
end

function BundlesOfFun.sync_bundle(bundle_name)
    if not G.P_CENTER_POOLS then return end
    BundlesOfFun.ensure_bundle_map()
    local items = BundlesOfFun.bundle_items[bundle_name]
    if not items then return end

    for _, center in ipairs(items) do
        -- Re-evaluate the full check_bundle_enabled using center.bundle
        local primary, secondary
        if type(center.bundle) == "string" then
            primary = center.bundle
        elseif type(center.bundle) == "table" then
            primary = center.bundle[1]
            secondary = center.bundle[2]
        end
        local enabled = check_bundle_enabled(primary, secondary)
        local pool_table = G.P_CENTER_POOLS[center.set]
        if pool_table then
            if enabled then
                -- Add to pool if not already present
                local found = false
                for _, v in ipairs(pool_table) do
                    if v.key == center.key then found = true; break end
                end
                if not found then
                    table.insert(pool_table, center)
                end
            else
                -- Remove from pool
                for i = #pool_table, 1, -1 do
                    if pool_table[i].key == center.key then
                        table.remove(pool_table, i)
                    end
                end
            end
        end
        -- Also handle custom pools (e.g. Consumable items with custom pool keys)
        if center.pools then
            for pool_key in pairs(center.pools) do
                local custom_pool = G.P_CENTER_POOLS[pool_key]
                if custom_pool then
                    if enabled then
                        local found = false
                        for _, v in ipairs(custom_pool) do
                            if v.key == center.key then found = true; break end
                        end
                        if not found then
                            table.insert(custom_pool, center)
                        end
                    else
                        for i = #custom_pool, 1, -1 do
                            if custom_pool[i].key == center.key then
                                table.remove(custom_pool, i)
                            end
                        end
                    end
                end
            end
        end
    end
end

function BundlesOfFun.sync_all_bundles()
    BundlesOfFun.ensure_bundle_map()
    if not BundlesOfFun.bundle_items then return end
    for bundle_name in pairs(BundlesOfFun.bundle_items) do
        BundlesOfFun.sync_bundle(bundle_name)
    end
end

function BundlesOfFun.refresh_collection_ui()
    if not G.DISCOVER_TALLIES or not G.P_CENTERS then return end
    -- vanilla set_discover_tallies uses `not v.no_collection` (boolean check), so it
    -- skips items whose no_collection is a function. Add those back if the function
    -- currently evaluates to false (bundle enabled → item should be counted).
    for _, v in pairs(G.P_CENTERS) do
        if not v.omit and type(v.no_collection) == 'function' and not v.no_collection() then
            if v.set == 'Joker' and G.DISCOVER_TALLIES.jokers then
                G.DISCOVER_TALLIES.jokers.of = G.DISCOVER_TALLIES.jokers.of + 1
                if v.discovered then G.DISCOVER_TALLIES.jokers.tally = G.DISCOVER_TALLIES.jokers.tally + 1 end
                G.DISCOVER_TALLIES.total.of = G.DISCOVER_TALLIES.total.of + 1
                if v.discovered then G.DISCOVER_TALLIES.total.tally = G.DISCOVER_TALLIES.total.tally + 1 end
            elseif v.set == 'Voucher' and G.DISCOVER_TALLIES.vouchers then
                G.DISCOVER_TALLIES.vouchers.of = G.DISCOVER_TALLIES.vouchers.of + 1
                if v.discovered then G.DISCOVER_TALLIES.vouchers.tally = G.DISCOVER_TALLIES.vouchers.tally + 1 end
                G.DISCOVER_TALLIES.total.of = G.DISCOVER_TALLIES.total.of + 1
                if v.discovered then G.DISCOVER_TALLIES.total.tally = G.DISCOVER_TALLIES.total.tally + 1 end
            elseif v.set == 'Booster' and G.DISCOVER_TALLIES.boosters then
                G.DISCOVER_TALLIES.boosters.of = G.DISCOVER_TALLIES.boosters.of + 1
                if v.discovered then G.DISCOVER_TALLIES.boosters.tally = G.DISCOVER_TALLIES.boosters.tally + 1 end
                G.DISCOVER_TALLIES.total.of = G.DISCOVER_TALLIES.total.of + 1
                if v.discovered then G.DISCOVER_TALLIES.total.tally = G.DISCOVER_TALLIES.total.tally + 1 end
            elseif v.set == 'Edition' and G.DISCOVER_TALLIES.editions then
                G.DISCOVER_TALLIES.editions.of = G.DISCOVER_TALLIES.editions.of + 1
                if v.discovered then G.DISCOVER_TALLIES.editions.tally = G.DISCOVER_TALLIES.editions.tally + 1 end
                G.DISCOVER_TALLIES.total.of = G.DISCOVER_TALLIES.total.of + 1
                if v.discovered then G.DISCOVER_TALLIES.total.tally = G.DISCOVER_TALLIES.total.tally + 1 end
            elseif v.consumeable and G.DISCOVER_TALLIES.consumeables then
                G.DISCOVER_TALLIES.consumeables.of = G.DISCOVER_TALLIES.consumeables.of + 1
                if v.discovered then G.DISCOVER_TALLIES.consumeables.tally = G.DISCOVER_TALLIES.consumeables.tally + 1 end
                local sub = G.DISCOVER_TALLIES[v.set:lower()..'s']
                if sub then
                    sub.of = sub.of + 1
                    if v.discovered then sub.tally = sub.tally + 1 end
                end
                G.DISCOVER_TALLIES.total.of = G.DISCOVER_TALLIES.total.of + 1
                if v.discovered then G.DISCOVER_TALLIES.total.tally = G.DISCOVER_TALLIES.total.tally + 1 end
            end
        end
    end
    for _, entry in pairs(G.DISCOVER_TALLIES) do
        if type(entry) == 'table' then
            entry.display = (entry.tally or 0)..' / '..(entry.of or 0)
        end
    end
end

function BundlesOfFun.on_bundle_toggle(bundle_name)
    -- Sync pools so items appear/disappear from shops/game
    BundlesOfFun.sync_bundle(bundle_name)
    -- If the mod overlay is open and we have a reference to the current tab's
    -- content container, rebuild it so the mod-additions page updates live.
    if BundlesOfFun.tab_content_box and G.ACTIVE_MOD_UI then
        local tabs = G.ACTIVE_MOD_UI.extra_tabs and G.ACTIVE_MOD_UI.extra_tabs()
        if tabs then
            -- Find which tab is active by scanning for a "chosen" tab button
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
                -- Create a fresh UIBox from the current tab definition and swap it in
                BundlesOfFun.tab_content_box.config.object = UIBox(tab_def.tab_definition_function())
                BundlesOfFun.tab_content_box:recalculate()
            end
        end
    end
end

-- Called when the mod overlay closes, to ensure tallies are fresh
function BundlesOfFun.on_exit_mods()
    -- Refresh discover tallies so the next collection page open sees correct numbers
    BundlesOfFun.refresh_collection_ui()
end

-- Replace the raw bundles config table with a proxy that fires on_bundle_toggle
-- whenever a value changes. This keeps the existing create_toggle UI working unchanged.
do
    local original = BundlesOfFun.config.bundles
    local proxy = {}
    -- Copy all existing keys onto the proxy so pairs() still works
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