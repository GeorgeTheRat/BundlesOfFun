SMODS.Joker {
    key = "j_ballbo",
    name = "Ballbo",
    config = {
        extra = {
            mult_mod = 1,
            mult_mod_mod = 0.5,
            mult = 0
        }
    },
    pos = { x = 8, y = 2 },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_mod,
                card.ability.extra.mult_mod_mod,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if next(context.poker_hands) == "Flush" and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "mult_mod",
                colour = G.C.CHIPS
            })
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult_mod",
                scalar_value = "mult_mod_mod",
                colour = G.C.CHIPS,
                no_message = true
            })
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
