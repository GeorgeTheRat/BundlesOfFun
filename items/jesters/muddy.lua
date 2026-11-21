BundlesOfFun.Joker {
    key = "muddy",
    name = "Muddy Joker",
    bundle = "jesters",
    config = {
        extra = {
            mult_mod = 2,
            hands = 0
        } 
    },
    pos = { x = 10, y = 4 },
    attributes = { "mult" },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_mod,
                card.ability.extra.hands * card.ability.extra.mult_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.hands * card.ability.extra.mult_mod
            }
        end
    end,
    joker_display_def = function()
        return {
            text = {
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "mult",
                    signed = true,
                    colour = G.C.MULT
                }
            },
            calc_function = function(card)
                card.joker_display_values.mult = card.ability.extra.hands * card.ability.extra.mult_mod
            end
        }
    end
}
