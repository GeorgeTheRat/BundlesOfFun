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

        -- end_of_round + main_eval fires once the round is fully resolved (same
        -- "round actually over" hook used by stress.lua/apple.lua), rather than
        -- context.before which fires while the final hand's scoring is still animating
        if context.end_of_round and context.main_eval and G.GAME.current_round.hands_left <= 0 then
            local target = G.jokers.cards[#G.jokers.cards]
            if target and not target.pinned then
                target:add_sticker("pinned", true)
                blind:wiggle()
            end
        end
    end
}