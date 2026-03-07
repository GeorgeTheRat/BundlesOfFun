SMODS.Joker({
	key = "j_schlitzohr",
	name = "Schlitzohr",
	pos = { x = 4, y = 2 },
	rarity = 3,
	blueprint_compat = true,
	atlas = "joker",
	calculate = function(self, card, context)
		if context.destroy_card and (context.cardarea == G.play or context.cardarea == "unscored") and G.GAME.current_round.hands_left > 0 then
            if context.destroy_card == pseudorandom_element(G.play.cards, pseudoseed("j_bof_j_schlitzohr")) then
                return {
                    remove = true
                }
            end
        end
	end,
})
