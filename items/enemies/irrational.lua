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

        -- three staggered shuffle+sound beats, same pacing as vanilla's Amber Acorn
        if context.before then
            G.E_MANAGER:add_event(Event({ func = function() G.hand:shuffle("bof_irrational"); play_sound('cardSlide1', 0.85); return true end }))
            delay(0.15)
            G.E_MANAGER:add_event(Event({ func = function() G.hand:shuffle("bof_irrational"); play_sound('cardSlide1', 1.15); return true end }))
            delay(0.15)
            G.E_MANAGER:add_event(Event({ func = function() G.hand:shuffle("bof_irrational"); play_sound('cardSlide1', 1); return true end }))
        end
    end
}