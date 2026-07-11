BundlesOfFun.Voucher {
    key = "ice_bucket",
    name = "Ice Bucket",
    bundle = { "coupons", { "fish" } },
    pos = { x = 3, y = 0 },
    atlas = "voucher",
    redeem = function(self, card, area)
        G.GAME.bof_fish_extra_rounds = (G.GAME.bof_fish_extra_rounds or 0) + 1
        if G.consumeables and G.consumeables.cards then
            for _, fish in ipairs(G.consumeables.cards) do
                BundlesOfFun.apply_fish_voucher_state(fish)
            end
        end
    end,
    unredeem = function(self, card, area)
        G.GAME.bof_fish_extra_rounds = (G.GAME.bof_fish_extra_rounds or 0) - 1
        if G.consumeables and G.consumeables.cards then
            for _, fish in ipairs(G.consumeables.cards) do
                BundlesOfFun.apply_fish_voucher_state(fish)
            end
        end
    end,
}