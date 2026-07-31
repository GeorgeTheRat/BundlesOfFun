BundlesOfFun.Joker {
    key = "gnome",
    name = "Garden Gnome",
    bundle = "normalities",
    pos = { x = 6, y = 6 },
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
        if
            context.post_trigger and
            context.other_card and
            (
                (
                    context.other_card.config.center and
                    (
                        context.other_card.config.center.key == "v_bof_dark_alley" or
                        context.other_card.config.center.key == "v_bof_illegal_wares"
                    )
                ) or (
                    context.other_card.effect and
                    context.other_card.effect.center and
                    context.other_card.effect.center.key == "b_bof_fossilized"
                )
            )
        then
            G.E_MANAGER:add_event(Event({
                func = function()
                    context.other_context.card.ability.couponed = true
                    context.other_context.card:set_cost()
                    return true
                end
            }))
            return nil, true
        end
    end
}