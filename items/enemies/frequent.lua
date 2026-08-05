-- cards of the most common suit are drawn face down
BundlesOfFun.Blind {
    key = "frequent",
    name = "The Frequent",
    bundle = "enemies",
    pos = { y = 12 },
    atlas = "blind",
    boss = { min = 2 },
    boss_colour = HEX("98a868"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        -- recompute the deck's most common suit whenever the hand's drawn or the blind's set
        if context.setting_blind or context.hand_drawn then
            local suit_counts = {}
            for _, c in ipairs(G.playing_cards) do
                local s = c.base.suit
                suit_counts[s] = (suit_counts[s] or 0) + 1
            end
            local most_common = nil
            local most_count = 0
            for suit, count in pairs(suit_counts) do
                if count > most_count then
                    most_common = suit
                    most_count = count
                end
            end
            G.GAME.bof_frequent_suit = most_common
        end

        -- deal face down if the card matches that suit
        if context.stay_flipped and context.to_area == G.hand and G.GAME.bof_frequent_suit then
            if context.other_card.base.suit == G.GAME.bof_frequent_suit then
                return { stay_flipped = true }
            end
        end
    end
}
