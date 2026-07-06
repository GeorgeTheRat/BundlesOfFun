BundlesOfFun.Voucher {
    key = "dark_alley",
    name = "Dark Alley",
    bundle = "coupons",
    config = { spectral_rate = 1 },
    pos = { x = 0, y = 0 },
    atlas = "voucher",
    redeem = function(self, card, area)
        if G.GAME.spectral_rate < self.config.spectral_rate then
            G.GAME.spectral_rate = self.config.spectral_rate
        end
    end
}