BundlesOfFun.Joker {
	key = "polymath",
	name = "Polymath",
	bundle = "jesters",
	config = {
		extra = {
			odds = 5,
			chips = 25,
			mult = 5,
			xmult = 1.25,
			dollars = 1,
		},
	},
	pos = { x = 6, y = 2 },
	attributes = { "mult", "chips", "xmult", "economy", "chance" },
	cost = 9,
	rarity = 3,
	blueprint_compat = true,
	atlas = "joker",
	loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_bof_polymath")
		return {
			vars = {
				numerator,
                denominator,
				card.ability.extra.chips,
				card.ability.extra.mult,
				card.ability.extra.xmult,
				card.ability.extra.dollars
			},
		}
	end,
	calculate = function(self, card, context)
		if context.individual and (context.cardarea == G.play or context.cardarea == G.hand) and not context.end_of_round then
            if SMODS.pseudorandom_probability(card, "j_bof_polymath", 1, card.ability.extra.odds) then
                return {
                    chips = card.ability.extra.chips,
                    mult = card.ability.extra.mult,
                    xmult = card.ability.extra.xmult,
                    dollars = card.ability.extra.dollars
                }
            end
		end
	end
}