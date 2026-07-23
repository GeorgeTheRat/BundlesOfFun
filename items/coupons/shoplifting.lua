BundlesOfFun.Voucher {
    key = "shoplifting",
    name = "Shoplifting",
    bundle = "coupons",
    requires = { "v_bof_unboxing" },
    pos = { x = 1, y = 1 },
    unlocked = false,
    atlas = "voucher",
    redeem = function(self, card, area)
        G.GAME.voucher_rate = 0.5
    end,
    unredeem = function(self, card, area)
        G.GAME.voucher_rate = nil
    end,
    check_for_unlock = function(self, args)
        return G.PROFILES[G.SETTINGS.profile].career_stats.bof_boosters_skipped and G.PROFILES[G.SETTINGS.profile].career_stats.bof_boosters_skipped >= 30
    end,
    locked_loc_vars = function(self)
        return { vars = { G.PROFILES[G.SETTINGS.profile].career_stats.bof_boosters_skipped or 0 } }
    end
}