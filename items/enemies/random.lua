-- shuffle cards in played hand
-- (handled by the G.FUNCS.evaluate_play hook in lib/hooks.lua, right before scoring begins -
-- not context.press_play, since that fires before G.play.cards is even populated)
BundlesOfFun.Blind {
    key = "random",
    name = "The Random",
    bundle = "enemies",
    pos = { y = 13 },
    atlas = "blind",
    boss = { min = 2 },
    boss_colour = HEX("88b8b8"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        -- three staggered shuffle+sound beats, same pacing as vanilla's Amber Acorn
        if context.before then
            G.E_MANAGER:add_event(Event({ func = function() G.play:shuffle("bof_random"); play_sound('cardSlide1', 0.85); return true end }))
            delay(0.15)
            G.E_MANAGER:add_event(Event({ func = function() G.play:shuffle("bof_random"); play_sound('cardSlide1', 1.15); return true end }))
            delay(0.15)
            G.E_MANAGER:add_event(Event({ func = function() G.play:shuffle("bof_random"); play_sound('cardSlide1', 1); return true end }))
        end
    end
}