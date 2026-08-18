BundlesOfFun.Joker {
    key = "band",
    name = "One-Man Band",
    bundle = "jesters",
    config = { extra = { mult = 15 } },
    pos = { x = 4, y = 6 },
    attributes = { "mult", "hand_type"},
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.scoring_name == "High Card" then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}