BundlesOfFun.Joker {
    key = "gary",
    name = "Geezer Gary",
    bundle = "jesters",
    config = { extra = { chips = 0 } },
    pos = { x = 10, y = 1 },
    attributes = { "chips", "scaling", "joker" },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    perishable_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.selling_card and context.card.ability.set == "Joker" and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_table = context.card,
                scalar_value = "sell_cost",
                scalar_factor = 2,
                message_colour = G.C.CHIPS
            })
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
    joker_display_def = function()
        return {
            text = {
                {
                    ref_table = "card.ability.extra",
                    ref_value = "chips",
                    retrigger_type = "*",
                    signed = true,
                    colour = G.C.CHIPS
                }
            }
        }
    end
}