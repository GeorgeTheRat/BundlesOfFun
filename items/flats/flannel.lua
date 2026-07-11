BundlesOfFun.Back {
	key = "flannel",
    name = "Flannel Deck",
    bundle = "flats",
    config = { mult = 4 },
	atlas = "deck",
	pos = { x = 1, y = 0 },
    unlocked = false,
    loc_vars = function(self, info_queue)
		return { vars = { self.config.mult } }
	end,
    calculate = function(self, back, context)
        if context.initial_scoring_step then
            return {
                mult = self.config.mult
            }
        end
    end,
    check_for_unlock = function(self, args)
        if G.GAME and G.GAME.hands then
            for hand_name, hand_data in pairs(G.GAME.hands) do
                if hand_data.mult and hand_data.mult >= 75 then
                    return true
                end
            end
        end
    end
}