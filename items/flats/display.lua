BundlesOfFun.Back {
	key = "display",
    name = "Display Deck",
    bundle = "flats",
	pos = { x = 5, y = 0 },
    unlocked = false,
    atlas = "deck",
    loc_vars = function(self, info_queue)
        return {
            key = BundlesOfFun.config.evil_dih and "b_bof_spaghetti_dih" or "b_bof_display",
            vars = {}
        }
    end,
    check_for_unlock = function(self, args)
        if args and args.type == "modify_deck" and G.GAME and G.GAME.blind then
            if G.GAME.bof_rerolled_showdown then
                return true
            end
        end
    end
}