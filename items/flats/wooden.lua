BundlesOfFun.Back {
	key = "wooden",
    name = "Wooden Deck",
    bundle = "flats",
    config = { remove_aces = true, extra_cards = { 2, 3, 4, 5 } },
	atlas = "deck",
	pos = { x = 2, y = 0 },
    unlocked = false,
    check_for_unlock = function(self, args)
        return args and args.b_bof_wooden
    end
}