SMODS.Joker({
	key = "j_schlitzohr",
	name = "Schlitzohr",
	config = {
		extra = {},
	},
	pos = { x = 0, y = 0 },
	rarity = 3,
	order = 27,
	blueprint_compat = true,
	atlas = "placeholder",
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.destroy_card and (context.cardarea == G.play or context.cardarea == "unscored") and G.GAME.current_round.hands_left > 0 then
            local a = pseudorandom_element(G.play.cards, pseudoseed("brr"))
            if context.destroy_card == a then
                return{
                    remove = true
                }
            end
        end
	end,
})
