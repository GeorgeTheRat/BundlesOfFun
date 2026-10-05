-- shuffle played and held cards
BundlesOfFun.Blind {
    key = "random",
    name = "The Random",
    bundle = "enemies",
    pos = { y = 13 },
    attributes = { "position" },
    atlas = "blind",
    boss = { min = 2 },
    boss_colour = HEX("88b8b8"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.press_play and #G.hand.cards > 0 then
            G.E_MANAGER:add_event(Event({ func = function() G.hand:shuffle("bof_random_hand"); play_sound('cardSlide1', 0.85); return true end }))
            delay(0.15)
            G.E_MANAGER:add_event(Event({ func = function() G.hand:shuffle("bof_random_hand"); play_sound('cardSlide1', 1.15); return true end }))
            delay(0.15)
            G.E_MANAGER:add_event(Event({ func = function() G.hand:shuffle("bof_random_hand"); play_sound('cardSlide1', 1); return true end }))
            delay(0.15)
        end

        if context.before and #G.play.cards > 0 then
            for _, card in ipairs(G.play.cards) do
                G.E_MANAGER:add_event(Event({ func = function() card:flip(); return true end }))
            end
            delay(0.15)
            G.E_MANAGER:add_event(Event({ func = function() G.play:shuffle("bof_random"); play_sound('cardSlide1', 0.85); return true end }))
            delay(0.15)
            G.E_MANAGER:add_event(Event({ func = function() G.play:shuffle("bof_random"); play_sound('cardSlide1', 1.15); return true end }))
            delay(0.15)
            G.E_MANAGER:add_event(Event({ func = function() G.play:shuffle("bof_random"); play_sound('cardSlide1', 1); return true end }))
            delay(0.15)
            for _, card in ipairs(G.play.cards) do
                G.E_MANAGER:add_event(Event({ func = function() card:flip(); return true end }))
            end
            delay(0.15)
        end
    end
}