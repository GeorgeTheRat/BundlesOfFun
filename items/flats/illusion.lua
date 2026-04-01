SMODS.Back {
	key = "illusion",
    name = "Illusion Deck",
    config = { stat_per_ante = 2, result = 0 },
	atlas = "deck",
	pos = { x = 4, y = 0 },
    unlocked = false,
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
    locked_loc_vars = function(self, info_queue, back)
        local red_deck = localize('k_unknown')
        if G.P_CENTERS["b_red"].unlocked then
            red_deck = localize { type = "name_text", set = "Back", key = "b_red" }
        end
        local blue_deck = localize('k_unknown')
        if G.P_CENTERS["b_blue"].unlocked then
            blue_deck = localize { type = "name_text", set = "Back", key = "b_blue" }
        end
        return {
            vars = {
                red_deck,
                localize { type = "name_text", set = "Stake", key = "stake_blue" },
                blue_deck,
                localize { type = "name_text", set = "Stake", key = "stake_red" },
                colours = {
                    get_stake_col(5),
                    get_stake_col(2)
                }
            }
        }
    end,
    check_for_unlock = function(self, args)
        return args.type == "win_stake" and (get_deck_win_stake("b_red") >= 5 or get_deck_win_stake("b_blue") >= 2)
    end
}
