BundlesOfFun.Voucher {
    key = "lottery_ticket",
    name = "Lottery Ticket",
    bundle = "coupons",
    requires = { "v_bof_scratch_off" },
    config = { extra = { reroll_count = 6 } },
    pos = { x = 1, y = 1 },
    attributes = { "shop", "reroll" },
    unlocked = false,
    atlas = "voucher",
    loc_vars = function(self)
        return { vars = { self.config.extra.reroll_count } }
    end,
    redeem = function()
        G.GAME.bof_lottery_ticket_shop_reroll_count = 0
    end,
    unredeem = function()
        G.GAME.bof_lottery_ticket_shop_reroll_count = 0
    end,
    check_for_unlock = function(self, args)
        return args.bof_vouchers_redeemed_this_ante and args.bof_vouchers_redeemed_this_ante >= 2
    end
}