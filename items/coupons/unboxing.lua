BundlesOfFun.Voucher {
    key = "unboxing",
    name = "Unboxing",
    bundle = "coupons",
    pos = { x = 2, y = 0 },
    attributes = { "shop", "booster" },
    atlas = "voucher",
    redeem = function()
        G.GAME.booster_rate = 2
    end,
    unredeem = function()
        G.GAME.booster_rate = nil
    end
}