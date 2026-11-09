BundlesOfFun.Voucher {
    key = "ice_bucket",
    name = "Ice Bucket",
    bundle = { "coupons", { "minnows" } },
    pos = { x = 2, y = 1 },
    attributes = { "fish" },
    atlas = "voucher",
    redeem = function()
        G.GAME.bof_fish_extra_rounds = (G.GAME.bof_fish_extra_rounds or 0) + 1
        if BOF.nc(G.consumeables, "cards") then
            for _, fish in ipairs(G.consumeables.cards) do
                BundlesOfFun.apply_fish_voucher_state(fish)
            end
        end
    end,
    unredeem = function()
        G.GAME.bof_fish_extra_rounds = (G.GAME.bof_fish_extra_rounds or 0) - 1
        if BOF.nc(G.consumeables, "cards") then
            for _, fish in ipairs(G.consumeables.cards) do
                BundlesOfFun.apply_fish_voucher_state(fish)
            end
        end
    end,
}