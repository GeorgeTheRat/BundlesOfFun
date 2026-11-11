BundlesOfFun.Blind {
	key = "fire",
	name = "Blazing Fire",
	bundle = "finishers",
	pos = { y = 25 },
	attributes = { "mult" },
	atlas = "blind",
	boss = { showdown = true },
	boss_colour = HEX("fd7857"),
	calculate = function(self, blind, context)
		if blind.disabled then return end

		if context.final_scoring_step and hand_chips * mult > blind.chips then
			G.E_MANAGER:add_event(Event({
				func = function()
					blind:wiggle()
					return true
				end
			}))
			mult = mod_mult(math.max(math.floor(mult * 0.2 + 0.5), 1))
			update_hand_text({}, { mult = mult })
		end
	end
}