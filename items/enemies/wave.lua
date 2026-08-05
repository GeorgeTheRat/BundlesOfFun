-- leftmost joker becomes pinned when final hand played
BundlesOfFun.Blind {
    key = "wave",
    name = "The Wave",
    bundle = "enemies",
    pos = { y = 23 },
    atlas = "blind",
    boss = { min = 3 },
    boss_colour = HEX("b8d878"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        -- press_play fires all together from play_cards_from_highlighted, before the
        -- queued hands_left decrement has actually run - context.before (dispatched
        -- later, from evaluate_play_main) is the consistent "final hand" check
        if context.before and G.GAME.current_round.hands_left <= 0 then
            local target = G.jokers.cards[1]
            if target and not target.pinned then
                target.pinned = true
                blind:wiggle()
            end
        end
    end
}
