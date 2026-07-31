BundlesOfFun.Voucher {
    key = "illegal_wares",
    name = "Illegal Wares",
    bundle = "coupons",
    requires = { "v_bof_dark_alley" },
    pos = { x = 0, y = 1 },
    unlocked = false,
    atlas = "voucher",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
    end,
    redeem = function(self, card, area)
        if G.GAME.spectral_rate then
            G.GAME.spectral_rate = G.GAME.spectral_rate * 3
        end
    end,
    unredeem = function(self, card, area)
        if G.GAME.spectral_rate then
            G.GAME.spectral_rate = G.GAME.spectral_rate / 3
        end
    end,
    check_for_unlock = function(self, args)
        if G.consumeables and G.consumeables.cards then
            local count = 0
            for _, c in ipairs(G.consumeables.cards) do
                if c.ability and c.ability.set == "Spectral" then
                    count = count + 1
                    if count >= 3 then
                        return true
                    end
                end
            end
        end
    end,
    calculate = function(self, card, context)
        if context.modify_shop_card and context.card.ability.consumeable and not context.card.edition then
            if pseudorandom(pseudoseed("b_bof_illegal_wares")) < 0.09 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.card:set_edition("e_negative", true)
                        return true
                    end
                }))
            end
        end
    end
}