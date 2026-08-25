BundlesOfFun.Joker {
    key = "phony",
    name = "Phony",
    bundle = "jesters",
    config = {
        extra = {
            mult = 8,
            chips = 10
        },
    },
    pos = BundlesOfFun.config.evil_dih and { x = 0, y = 0 } or { x = 0, y = 4 },
    attributes = { "mult", "chips" },
    cost = 2,
    rarity = 1,
    blueprint_compat = true,
    atlas = BundlesOfFun.config.evil_dih and "evil_dih" or "joker",
    loc_vars = function(self, info_queue, card)
        return {
            key = BundlesOfFun.config.evil_dih and "j_bof_gucci_morty" or "j_bof_phony",
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