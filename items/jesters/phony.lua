BundlesOfFun.Joker {
    key = "phony",
    name = "Phony",
    bundle = "jesters",
    config = {
        extra = {
            mult = 6,
            chips = 10
        },
    },
    pos = { x = 0, y = 4 },
    attributes = { "mult", "chips" },
    cost = 2,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
                chips = -card.ability.extra.chips
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "-", colour = G.C.CHIPS },
                { ref_table = "card.ability.extra", ref_value = "chips", colour = G.C.CHIPS },
                { text = " +", colour = G.C.MULT },
                { ref_table = "card.ability.extra", ref_value = "mult", colour = G.C.MULT }
            }
        }
    end
}