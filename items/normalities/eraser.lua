BundlesOfFun.Joker {
    key = "eraser",
    name = "Eraser",
    bundle = "normalities",
    config = { extra = { mult = 2 } },
    pos = { x = 6, y = 3 },
    pixel_size = { w = 57 },
    attributes = { "mult", "enhancements", "seals", "editions" },
    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "k_bof_modification" }
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for k, v in ipairs(G.hand.cards) do
                if v.base.value then
                    v:set_ability("c_base", nil, true)
                    v:set_edition(nil, nil, nil, true)
                    if v.seal then
                        v.ability.bof_delay_seal_removal = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                v:set_seal(nil)
                                v.ability.bof_delay_seal_removal = nil
                                return true
                            end
                        }))
                    end
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    }))
                end
            end
            return {
                message = localize("k_erased")
            }
        end
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}