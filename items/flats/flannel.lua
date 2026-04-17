SMODS.Back {
	key = "l_flannel",
    name = "Flannel Deck",
    config = { mult = 4 },
	atlas = "deck",
	pos = { x = 1, y = 0 },
    unlocked = false,
    loc_vars = function(self, info_queue)
		return { vars = { self.config.mult } }
	end,
    calculate = function(self, back, context)
        if context.final_scoring_step then
            return {mult = 4}
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