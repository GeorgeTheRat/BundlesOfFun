BundlesOfFun.Voucher {
    key = "unboxing",
    name = "Unboxing",
    bundle = "coupons",
    pos = { x = 1, y = 0 },
    atlas = "voucher",
    redeem = function(self, card, area)
        G.GAME.booster_rate = 2
    end,
    unredeem = function(self, card, area)
        G.GAME.booster_rate = nil
    end
}