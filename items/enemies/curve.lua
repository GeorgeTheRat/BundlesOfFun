-- decrease level of discarded poker hands
BundlesOfFun.Blind {
    key = "curve",
    name = "The Curve",
    bundle = "enemies",
    pos = { y = 9 },
    attributes = { "hand_type", "hand_level", "discard" },
    atlas = "blind",
    boss = { min = 3 },
    boss_colour = HEX("c8d8e8"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.first_hand_drawn then
            G.GAME.current_round.hands_left = math.max(0, G.GAME.current_round.hands_left - 1)
        end

        -- figure out what poker hand the discarded cards would form and drop that hand's level
        if context.pre_discard and context.full_hand and #context.full_hand > 0 then
            local hand_name = G.FUNCS.get_poker_hand_info(context.full_hand)
            local hand_data = hand_name and G.GAME.hands[hand_name]
            if hand_data and hand_data.level > 1 then
                SMODS.upgrade_poker_hands({
                    hands = hand_name,
                    level_up = -1,
                    from = blind
                })
            end
        end
    end
}