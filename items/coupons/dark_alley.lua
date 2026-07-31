BundlesOfFun.Voucher {
    key = "dark_alley",
    name = "Dark Alley",
    bundle = "coupons",
    pos = { x = 0, y = 0 },
    atlas = "voucher",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
    end,
    redeem = function(self, card, area) -- done this way to make sure not to affect ghost deck
        if G.GAME.spectral_rate < 1 then
            G.GAME.spectral_rate = 1
        end
    end,
    unredeem = function(self, card, area)
        if G.GAME.spectral_rate == 1 then
            G.GAME.spectral_rate = 0
        end
    end,
    calculate = function(self, card, context)
        if context.modify_shop_card and context.card.ability.consumeable and not context.card.edition then
            if not G.GAME.used_vouchers["v_bof_illegal_wares"] then
                local back = G.GAME and G.GAME.selected_back
                if not (back and back.effect and back.effect.center and back.effect.center.key == "b_bof_fossilized") then
                    if pseudorandom(pseudoseed("b_bof_dark_alley")) < 0.03 then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                context.card:set_edition("e_negative", true)
                                return true
                            end
                        }))
                        return nil, true
                    end
                end
            end
        end
    end
}