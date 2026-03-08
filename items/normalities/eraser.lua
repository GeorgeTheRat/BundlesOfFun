SMODS.Joker {
    key = "n_eraser",
    name = "Eraser",
    config = { extra = { mult = 2 } },
    pos = { x = 6, y = 3 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.before then
            return {
                message = "Erased!",
                func = function()
                    for k, v in ipairs(G.hand.cards) do
                        if v.base.value then
                            v:set_ability("c_base", nil, true)
                            v:set_edition(nil, nil, nil, true)
                            v:set_seal(nil)
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    v:juice_up()
                                    return true
                                end
                            }))
                        end
                    end
                    return true
                end
            }
        end
    end
}