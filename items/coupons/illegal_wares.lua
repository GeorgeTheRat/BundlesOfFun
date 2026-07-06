BundlesOfFun.Voucher {
    key = "illegal_wares",
    name = "Illegal Wares",
    bundle = "coupons",
    requires = { "v_bof_dark_alley" },
    config = { extra = { spectral_rate = 3 } },
    pos = { x = 0, y = 1 },
    atlas = "voucher",
    redeem = function(self, card, area)
        if G.GAME.spectral_rate < self.config.extra.spectral_rate then
            G.GAME.spectral_rate = self.config.extra.spectral_rate
        end
    end
}