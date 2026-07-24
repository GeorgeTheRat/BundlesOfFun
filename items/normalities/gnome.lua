BundlesOfFun.Joker {
    key = "gnome",
    name = "Garden Gnome",
    bundle = "normalities",
    -- pos = { x = 0, y = 0 },
    attributes = { "passive", "economy" },
    cost = 6,
    rarity = 1,
    blueprint_compat = false,
    atlas = "placeholder",
    calculate = function(self, card, context)
        if context.modify_shop_card and context.card.edition then
            G.E_MANAGER:add_event(Event({
                func = function()
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    return true
                end
            }))
        end
    end
}