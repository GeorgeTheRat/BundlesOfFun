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

return true