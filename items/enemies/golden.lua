-- lose $3 per card in hand at the end of the round (mirrors The Tooth)
BundlesOfFun.Blind {
    key = "golden",
    name = "The Golden",
    bundle = "enemies",
    pos = { y = 21 },
    atlas = "blind",
    boss = { min = 5 },
    -- again this felt too punishing (atleast for low-card hands) too put
    -- too early, this feels like the best spot where you actually have econ
    boss_colour = HEX("687898"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.end_of_round and context.main_eval then
            local hand_cards = G.hand and G.hand.cards
            if hand_cards then
                ease_dollars(-#hand_cards * 3)
            end
        end
    end
}
