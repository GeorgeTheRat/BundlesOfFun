BundlesOfFun.Voucher {
    key = "scratch_off",
    name = "Scratch-Off",
    bundle = "coupons",
    config = { extra = { reroll_count = 3 } },
    pos = { x = 2, y = 0 },
    atlas = "voucher",
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.reroll_count } }
    end,
    redeem = function(self, card, area)
        G.GAME.bof_scratch_off_shop_reroll_count = 0
    end,
    unredeem = function(self, card, area)
        G.GAME.bof_scratch_off_shop_reroll_count = 0
    end
}