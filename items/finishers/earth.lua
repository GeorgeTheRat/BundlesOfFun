BundlesOfFun.Blind {
	key = "earth",
	name = "Rooted Earth",
	bundle = "finishers",
	pos = { y = 28 },
	attributes = { "enhancement" },
	atlas = "blind",
	boss = { showdown = true },
	boss_colour = HEX("b5b26b"),
	calculate = function(self, blind, context)
		if blind.disabled or not context.hand_drawn then return end

		local unenhanced = {}
		for _, card in ipairs(context.hand_drawn) do
			if next(SMODS.get_enhancements(card) or {}) then
				unenhanced[#unenhanced + 1] = card
			end
		end
		if #unenhanced > 0 then
			G.E_MANAGER:add_event(Event({
				func = function()
					for _, card in ipairs(unenhanced) do
						card:juice_up(0.1, 0.3)
						card:set_ability(G.P_CENTERS.c_base, nil, true)
					end
					blind:wiggle()
					return true
				end
			}))
		end
	end
}