BundlesOfFun.Blind {
	key = "air",
	name = "Howling Air",
	bundle = "finishers",
	pos = { y = 27 },
	attributes = { "ante", "skip", "large_blind" },
	atlas = "blind",
	boss = { showdown = true },
	dollars = 8,
	mult = 4,
	boss_colour = HEX("97c9d4"),
	set_blind = function(self, reset, silent)
		if reset then return end
		BundlesOfFun.refresh_air_blinds("bl_bof_air")
	end
}