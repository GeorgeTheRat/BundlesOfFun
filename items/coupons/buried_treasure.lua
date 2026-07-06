BundlesOfFun.Voucher {
    key = "buried_treasure",
    name = "Buried Treasure",
    bundle = "coupons",
    requires = { "v_bof_ice_bucket" },
    pos = { x = 3, y = 1 },
    unlocked = false,
    atlas = "voucher",
    locked_loc_vars = function(self, info_queue)
        return { vars = { G.GAME and G.GAME.bof_fish_expired or 0 } }
    end,
    redeem = function(self, card, area)
        G.GAME.bof_fish_extra_consumable_slots = (G.GAME.bof_fish_extra_consumable_slots or 0) + 1
        if G.consumeables and G.consumeables.cards then
            for _, fish in ipairs(G.consumeables.cards) do
                BundlesOfFun.apply_fish_voucher_state(fish)
            end
        end
    end,
    check_for_unlock = function(self, args)
        return args and args.bof_fish_expired and args.bof_fish_expired >= 5
    end
}