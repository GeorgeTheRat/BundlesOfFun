BundlesOfFun.Voucher {
    key = "scratch_off",
    name = "Scratch-Off",
    bundle = "coupons",
    atlas = "voucher",
    pos = { x = 2, y = 0 },
    apply = function(self, card, area)
        if G.GAME.bof_scratch_off_skips and G.GAME.bof_scratch_off_skips.small and G.GAME.bof_scratch_off_skips.big then
            local eligible = {}
            local purchased = {}
            for key, _ in pairs(G.GAME.used_vouchers) do
                purchased[key] = true
            end
            for key, center in pairs(G.P_CENTERS) do
                if center.set == "Voucher" then
                    local requires = center.requires
                    local meets_requirements = true
                    if requires then
                        if type(requires) == "table" then
                            for _, req_key in ipairs(requires) do
                                if not purchased[req_key] then
                                    meets_requirements = false
                                    break
                                end
                            end
                        elseif type(requires) == "string" then
                            if not purchased[requires] then
                                meets_requirements = false
                            end
                        end
                    end
                    if meets_requirements then
                        table.insert(eligible, center)
                    end
                end
            end
            if #eligible > 0 then
                local idx = pseudorandom(pseudoseed("bof_scratch_off"), 1, #eligible)
                local voucher = eligible[idx]
                if voucher then
                    G.GAME.used_vouchers[voucher.key] = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local voucher_card = SMODS.create_card({ area = G.play, key = voucher.key })
                            voucher_card:add_to_deck()
                            voucher_card:start_materialize()
                            voucher_card.cost = 0
                            G.play:emplace(voucher_card)
                            G.FUNCS.use_card({ config = { ref_table = voucher_card } })
                            return true
                        end
                    }))
                end
            end
        end
    end
}