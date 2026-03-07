SMODS.Joker({
	key = "j_polymath",
	name = "Polymath",
	config = {
		extra = {
			odds = 5,
			mult = 3,
			chips = 12,
			xmult = 1.2,
			balance = 5,
			dollars = 1,
		},
	},
	pos = { x = 6, y = 2 },
	cost = 9,
	rarity = 3,
	blueprint_compat = true,
	atlas = "joker",
	loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_bof_j_polymath")
		return {
			vars = {
				numerator,
                denominator,
				card.ability.extra.mult,
				card.ability.extra.chips,
				card.ability.extra.xmult,
				card.ability.extra.balance,
				card.ability.extra.dollars,
                colours = { { 0.8, 0.45, 0.85, 1 } }
			},
		}
	end,
	calculate = function(self, card, context)
		if context.individual and (context.cardarea == G.play or context.cardarea == G.hand) and not context.end_of_round then
            if SMODS.pseudorandom_probability(card, "j_bof_j_polymath", 1, card.ability.extra.odds) then
                return {
                    chips = card.ability.extra.chips,
                    mult = card.ability.extra.mult,
                    xchips = card.ability.extra.xmult,
                    dollars = card.ability.extra.dollars,
                    bof_balance_percent = card.ability.extra.balance * 0.01
                }
            end
		end
	end
})
