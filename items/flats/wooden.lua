SMODS.Back {
	key = "l_wooden",
    name = "Wooden Deck",
    config = { remove_aces = true, extra_cards = { 2, 3, 4, 5 } },
	atlas = "deck",
	pos = { x = 2, y = 0 },
    unlocked = false,
    check_for_unlock = function(self)
        if G.GAME and G.GAME.bof_wooden_destroyed and G.GAME.bof_wooden_destroyed >= 4 then
            unlock_card(self)
            return true
        end
        return false
    end
}