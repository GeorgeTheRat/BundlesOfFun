BundlesOfFun.Joker {
    key = "gary",
    name = "Geezer Gary",
    bundle = "jesters",
    config = {
        extra = {
            chips = 0,
            chips_mod = nil
        }
    },
    pos = { x = 0, y = 3 },
    attributes = { "chips", "scaling", "joker" },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    perishable_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.selling_card and context.card.ability.set == "Joker" and not context.blueprint then
            card.ability.extra.chips_mod = G.GAME.round_resets.ante or 1
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chips_mod",
                message_colour = G.C.CHIPS
            })
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}