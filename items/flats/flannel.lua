SMODS.Back {
	key = "flannel",
    name = "Flannel Deck",
    config = { mult = 4 },
	atlas = "deck",
	pos = { x = 1, y = 0 },
    unlocked = false,
    loc_vars = function(self, info_queue)
		return { vars = { self.config.mult } }
	end,
    trigger_effect = function(self, args)
        if args.context == "final_scoring_step" then
            args.mult = args.mult + self.config.mult
            update_hand_text({delay = 0}, {mult = args.mult})
            G.E_MANAGER:add_event(Event({
                func = (function()
                    play_sound("multhit1", 1, 1)
                    play_sound("tarot1", 1.5)
                    attention_text({
                        scale = 1.4, text = "+"..self.config.mult.." Mult", hold = 2, align = "cm", offset = {x = 0,y = -2.7}, major = G.play
                    })
                    return true
                end)
            }))
        end
    end,
    hooks = {
        level_up_hand = function(self, hand)
            self:check_for_unlock()
        end
    },
    check_for_unlock = function(self)
        if G.GAME and G.GAME.hands then
            for hand_name, hand_data in pairs(G.GAME.hands) do
                if hand_data.visible and hand_data.mult and hand_data.mult >= 75 then
                    unlock_card(self)
                    return true
                end
            end
        end
        return false
    end
}