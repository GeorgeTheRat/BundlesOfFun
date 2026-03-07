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
            G.E_MANAGER:add_event(Event({
                func = function()
                    for k, v in ipairs(G.hand.cards) do
                        if v.base.value then
                            v:set_ability(G.P_CENTERS.c_base)
                            v:set_edition(nil)
                            v:set_seal(nil)
                            v:juice_up()
                        end
                    end
                    return true
                end
            }))
            return {
                message = "Erased!"
            }
        end
    end
}