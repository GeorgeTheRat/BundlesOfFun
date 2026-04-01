SMODS.Back {
	key = "l_soapy",
    name = "Soapy Deck",
	atlas = "deck",
	pos = { x = 6, y = 0 },
    unlocked = false,
    loc_vars = function(self, info_queue)
		return { vars = {} }
	end,
    check_for_unlock = function(self)
        if G.GAME and G.GAME.bof_soapy_destroyed then
            for key, _ in pairs(G.GAME.bof_soapy_destroyed) do
                unlock_card(self)
                return true
            end
        end
        return false
    end,
    calculate = function(self, back, context)
        if context.discard then
            if next(SMODS.get_enhancements(context.other_card)) ~= nil then
                return {
                    remove = true
                }
            end
        end
    end
}