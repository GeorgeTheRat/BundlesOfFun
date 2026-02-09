SMODS.Joker {
    key = "f_turold",
    name = "Turold",
    config = {
        extra = {
            xmult_mod = 1.5,
            xmult = 1
        }
    },
    pos = { x = 0, y = 0 },
    cost = 20,
    rarity = 4,
    -- order = 0,
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_mod,
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmult_mod",
                message_colour = G.C.MULT
            })
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.xmult = 1
            return {
                message = "Reset!",
                colour = G.C.MULT
            }
        end
    end
}