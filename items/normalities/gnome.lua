BundlesOfFun.Joker {
    key = "gnome",
    name = "Garden Gnome",
    bundle = "normalities",
    pos = { x = 6, y = 9 },
    attributes = { "passive", "economy" },
    cost = 6,
    rarity = 1,
    blueprint_compat = false,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.modify_shop_card then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if context.card.edition then
                        context.card.ability.couponed = true
                        context.card:set_cost()
                    end
                    return true
                end
            }))
        end
    end,
    JokerDisplay = function()
    end
}