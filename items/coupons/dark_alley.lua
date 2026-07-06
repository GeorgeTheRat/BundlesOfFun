BundlesOfFun.Voucher {
    key = "dark_alley",
    name = "Dark Alley",
    bundle = "coupons",
    config = { spectral_rate = 69 },
    pos = { x = 0, y = 0 },
    atlas = "voucher",
    redeem = function(self, card, area)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.spectral_rate = self.config.spectral_rate
                return true
            end
        }))
    end
}