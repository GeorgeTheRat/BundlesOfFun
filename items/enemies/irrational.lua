-- cards held in hand are shuffled each draw
-- i feel this one is really weak; but the effect was there and so i made it
BundlesOfFun.Blind {
    key = "irrational",
    name = "The Irrational",
    bundle = "enemies",
    pos = { y = 15 },
    atlas = "blind",
    boss = { min = 3 },
    boss_colour = HEX("d8d888"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        -- vanilla CardArea:shuffle handles re-running set_ranks so the new order sticks
        if context.hand_drawn then
            G.hand:shuffle("bof_irrational")
        end
    end
}
