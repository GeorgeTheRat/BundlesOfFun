SMODS.Back {
	key = "l_lightning",
    name = "Lightning Deck",
	pos = { x = 0, y = 0 },
    unlocked = false,
    atlas = "deck",
    check_for_unlock = function(self, args)
        return args.type == "win" and not G.GAME.mult_scored_this_run
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, playing_card in ipairs(G.playing_cards) do
                    if playing_card:is_face() then
                        playing_card:set_ability("m_mult", nil, nil)
                    end
                end
                return true
            end
        }))
    end
}
