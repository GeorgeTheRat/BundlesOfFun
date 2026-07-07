BundlesOfFun.Voucher {
    key = "lottery_ticket",
    name = "Lottery Ticket",
    bundle = "coupons",
    requires = { "v_bof_scratch_off" },
    config = { extra = { reroll_count = 4 } },
    atlas = "voucher",
    pos = { x = 2, y = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.reroll_count } }
    end,
    redeem = function(self, card, area)
        G.GAME.bof_lottery_ticket_shop_reroll_count = 0
    end
}