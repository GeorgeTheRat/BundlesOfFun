BundlesOfFun.Back {
	key = "display",
    name = "Display Deck",
    bundle = "flats",
	pos = { x = 5, y = 0 },
    unlocked = false,
    atlas = "deck",
    check_for_unlock = function(self, args)
        if args and args.type == "modify_deck" and G.GAME and G.GAME.blind then
            if G.GAME.bof_rerolled_showdown then
                return true
            end
        end
    end
}