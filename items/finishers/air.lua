BundlesOfFun.Blind {
	key = "air",
	name = "Howling Air",
	bundle = "finishers",
	pos = { y = 27 },
	attributes = { "ante", "skip", "large_blind" },
	atlas = "blind",
	boss = { showdown = true },
	mult = 4,
	boss_colour = HEX("97c9d4"),
	set_blind = function(self, reset, silent)
		if reset then return end
		local was_active = BundlesOfFun.air_active()
		G.GAME.bof_air_active_ante = G.GAME.round_resets.ante
		BundlesOfFun.refresh_air_blinds(was_active)
		BundlesOfFun.juice_air_blind_scores()
		BundlesOfFun.air_activation_sound()
	end
}