-- lose $3 per card in hand at the end of the round (mirrors The Tooth)
BundlesOfFun.Blind {
    key = "golden",
    name = "The Golden",
    bundle = "enemies",
    pos = { y = 21 },
    atlas = "blind",
    boss = { min = 4 },
    -- again this felt too punishing (atleast for low-card hands) too put
    -- too early, this feels like the best spot where you actually have econ
    boss_colour = HEX("687898"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.individual and context.cardarea == G.hand and context.end_of_round then
            return {
                dollars = -3
            }
        end
    end
}