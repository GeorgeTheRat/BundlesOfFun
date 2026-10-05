BundlesOfFun.Back {
	key = "scaly",
    name = "Scaly Deck",
    bundle = "flats",
    config = {
        voucher = "v_bof_ice_bucket",
        consumables = { "c_bof_octopus_b" }
    },
    unlocked = false,
    atlas = "deck",
    pos = { x = 10, y = 0 },
    attributes = { "generation", "consumable", "fish" },
    check_for_unlock = function(self, args)
        return args and args.b_bof_scaly
    end
}