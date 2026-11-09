BundlesOfFun.Voucher {
    key = "scratch_off",
    name = "Scratch-Off",
    bundle = "coupons",
    config = { extra = { reroll_count = 3 } },
    pos = { x = 0, y = 1 },
    attributes = { "shop", "reroll" },
    atlas = "voucher",
    loc_vars = function(self)
        return { vars = { self.config.extra.reroll_count } }
    end,
    redeem = function()
        G.GAME.bof_scratch_off_shop_reroll_count = 0
    end,
    unredeem = function()
        G.GAME.bof_scratch_off_shop_reroll_count = 0
    end
}