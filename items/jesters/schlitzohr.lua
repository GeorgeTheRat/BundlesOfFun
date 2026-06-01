SMODS.Joker({
	key = "j_schlitzohr",
	name = "Schlitzohr",
	config = { extra = { card = nil } },
	pos = { x = 4, y = 2 },
	cost = 8,
	rarity = 3,
	blueprint_compat = true,
	atlas = "joker",
	calculate = function(self, card, context)
		if context.before then
			if context.blueprint then
				context.blueprint_card.ability.modprefix_schlitzohr_card = pseudorandom_element(context.full_hand, self.key).unique_val
				return nil
			end
			card.ability.extra.card = pseudorandom_element(context.full_hand, self.key).unique_val
		end
		if context.destroy_card and (context.cardarea == G.play or context.cardarea == "unscored") and G.GAME.current_round.hands_left > 0 then
			if context.blueprint and (context.destroy_card.unique_val == context.blueprint_card.ability.modprefix_schlitzohr_card) or context.destroy_card.unique_val == card.ability.extra.card then
				return {
					remove = true,
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								card:juice_up(0.3, 0.5)
								return true
							end
						}))
					end
				}
			end
		end
	end
})