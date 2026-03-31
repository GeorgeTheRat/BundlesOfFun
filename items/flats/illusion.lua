SMODS.Back {
	key = "illusion",
    name = "Illusion Deck",
    config = { stat_per_ante = 2, result = 0 },
	atlas = "deck",
	pos = { x = 4, y = 0 },
    -- unlocked = false,
    loc_vars = function(self, info_queue)
		return { vars = { self.config.stat_per_ante } }
	end,
    calculate = function(self, back, context)
        if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss then
            if self.config.result == 1 then
                G.GAME.round_resets.hands = G.GAME.round_resets.hands - self.config.stat_per_ante
                ease_hands_played(-self.config.stat_per_ante)
            elseif self.config.result == 2 then
                G.GAME.round_resets.discards = G.GAME.round_resets.discards - self.config.stat_per_ante
                ease_discard(-self.config.stat_per_ante)
            end
            if pseudorandom("illusion") > 0.5 then
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + self.config.stat_per_ante
                ease_hands_played(self.config.stat_per_ante)
                self.config.result = 1
            else
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + self.config.stat_per_ante
                ease_discard(self.config.stat_per_ante)
                self.config.result = 2
            end
        end
    end,
    -- check_for_unlock = function(self, args)
    --     if args.type == "win_deck" and args.deck then
    --         local deck_key = args.deck.key
    --         local stake_level = args.stake_level or 1
            
    --         return (deck_key == "b_blue" and stake_level == 2) or (deck_key == "b_red" and stake_level == 5)
    --     end
    --     return false
    -- end
}