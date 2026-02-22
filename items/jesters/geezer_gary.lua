SMODS.Joker {
    key = "j_geezer_gary",
    name = "Geezer Gary",
    config = {
        extra = {
            chips_mod = 2,
            chips_mod_mod = 1,
            chips = 0
        }
    },
    pos = { x = 4, y = 1 },
    cost = 5,
    rarity = 1,
    order = 21,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips_mod,
                card.ability.extra.chips_mod_mod,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_card and context.card.ability.set == "Joker" and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chips_mod",
                message_colour = G.C.CHIPS
            })
        end
        if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips_mod",
                scalar_value = "chips_mod_mod",
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