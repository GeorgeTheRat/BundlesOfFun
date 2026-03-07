SMODS.Joker({
	key = "j_luminary",
	name = "Luminary",
	config = {
		extra = {
			dollars = 1,
            dollars_mod = 2,
            triggered = 0,
            hand_triggered = 0
		},
	},
	pos = { x = 9, y = 2 },
	cost = 6,
	rarity = 1,
	blueprint_compat = true,
	atlas = "joker",
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
                card.ability.extra.dollars,
                card.ability.extra.dollars_mod,
			}
		}
	end,
	calculate = function(self, card, context)
		if
            context.cardarea == "unscored" and
            context.individual and
            card.ability.extra.hand_triggered == 0 and
            (context.other_card:is_suit("Hearts") or context.other_card:is_suit("Diamonds"))
        then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "dollars",
                scalar_value = "dollars_mod",
                message_colour = G.C.MONEY
            })
            card.ability.extra.triggered = card.ability.extra.triggered + 1
            card.ability.extra.hand_triggered = 1
		end
        if context.after then
            card.ability.extra.hand_triggered = 0
        end
        if context.starting_shop then
            card.ability.extra.dollars = math.max(1, card.ability.extra.dollars - (card.ability.extra.triggered * card.ability.extra.dollars_mod)) -- this is for compatibility with value manipulation
            card.ability.extra.triggered = 0
        end
	end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end
})
