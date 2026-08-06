-- decrease level of discarded poker hands
BundlesOfFun.Blind {
    key = "curve",
    name = "The Curve",
    bundle = "enemies",
    pos = { y = 9 },
    atlas = "blind",
    boss = { min = 3 },
    boss_colour = HEX("c8d8e8"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        -- figure out what poker hand the discarded cards would form and drop that hand's level
        if context.pre_discard and context.full_hand and #context.full_hand > 0 then
            local hand_name = G.FUNCS.get_poker_hand_info(context.full_hand)
            local hand_data = hand_name and G.GAME.hands[hand_name]
            if hand_data and hand_data.level > 1 then
                hand_data.level = hand_data.level - 1
                blind:wiggle()
            end
        end
    end
}
