-- rightmost joker becomes pinned when final hand played
BundlesOfFun.Blind {
    key = "wave",
    name = "The Wave",
    bundle = "enemies",
    pos = { y = 23 },
    atlas = "blind",
    boss = { min = 2 },
    boss_colour = HEX("b8d878"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        -- fires on context.after
        if context.after and G.GAME.current_round.hands_left <= 0 then
            local target = G.jokers.cards[#G.jokers.cards]
            if target and not target.pinned then
                target:add_sticker("pinned", true)
                blind:wiggle()
            end
        end
    end
}