BundlesOfFun.Back {
	key = "scaly",
    name = "Scaly Deck",
    bundle = { "flats", { "coupons", "minnows" } },
    config = {
        voucher = "v_bof_ice_bucket",
        consumables = { "c_bof_octopus_b" }
    },
    attributes = { "generation", "consumable", "fish" },
    unlocked = false,
    atlas = "deck",
    pos = { x = 10, y = 0 },
    check_for_unlock = function(self, args)
        return args and args.b_bof_scaly
    end
}