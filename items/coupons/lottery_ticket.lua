BundlesOfFun.Voucher {
    key = "lottery_ticket",
    name = "Lottery Ticket",
    bundle = "coupons",
    requires = { "v_bof_scratch_off" },
    config = { extra = { reroll_count = 6 } },
    pos = { x = 2, y = 1 },
    unlocked = false,
    atlas = "voucher",
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.reroll_count } }
    end,
    redeem = function(self, card, area)
        G.GAME.bof_lottery_ticket_shop_reroll_count = 0
    end,
    unredeem = function(self, card, area)
        G.GAME.bof_lottery_ticket_shop_reroll_count = 0
    end,
    check_for_unlock = function(self, args)
        return args and args.bof_vouchers_redeemed_this_ante and args.bof_vouchers_redeemed_this_ante >= 3
    end
}