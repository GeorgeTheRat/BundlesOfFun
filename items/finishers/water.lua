BundlesOfFun.Blind {
	key = "water",
	name = "Tidal Water",
	bundle = "finishers",
	pos = { y = 26 },
	attributes = { "debuff", "joker" },
	atlas = "blind",
	boss = { showdown = true },
	boss_colour = HEX("39869e"),
	calculate = function(self, blind, context)
		if blind.disabled then return end

		if context.debuff_card and context.debuff_card.area == G.jokers then
			local jokers = G.jokers.cards
			return { debuff = #jokers > 0 and (context.debuff_card == jokers[1] or context.debuff_card == jokers[#jokers]) }
		end
	end
}