SMODS.Back {
	key = "l_retro",
    name = "Retro Deck",
    config = { extra = { hands = 4 } },
	atlas = "deck",
	pos = { x = 7, y = 0 },
    unlocked = false,
    loc_vars = function(self, info_queue)
		return { vars = { self.config.extra.hands } }
	end,
    check_for_unlock = function(self, args)
        if args and args.type == "hand" and G.GAME and G.GAME.hands then
            local base_hands = { -- Why hardcoded? bc you can have mods adding extra hand types and this is easier than making exceptions for other mods
                "High Card",
                "Pair",
                "Two Pair",
                "Three of a Kind",
                "Straight",
                "Flush",
                "Full House",
                "Four of a Kind",
                "Straight Flush"
            }
            for _, hand_name in ipairs(base_hands) do
                local hand_data = G.GAME.hands[hand_name]
                if hand_data and (hand_data.played or 0) < 1 then
                    return false
                end
            end
            return true
        end
    end
}