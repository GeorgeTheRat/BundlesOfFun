SMODS.Joker {
    key = "a_leek",
    name = "Leek",
    config = {
        extra = {
            prob_start = 3.9,
            prob_current = nil,
            prob_mod = 0.1
        }
    },
    pos = { x = 8, y = 0 },
    cost = 4,
    rarity = 2,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        if not card.ability.extra.prob_current then
            card.ability.extra.prob_current = card.ability.extra.prob_start 
        end
        return {
            vars = {
                card.ability.extra.prob_current,
                card.ability.extra.prob_mod
            } 
        }
    end,
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            card.ability.extra.prob_current = card.ability.extra.prob_current or card.ability.extra.prob_start
            return {
                numerator = context.numerator + card.ability.extra.prob_current
            }
        end
        if context.pseudorandom_result and context.result then
            card.ability.extra.prob_current = card.ability.extra.prob_current or card.ability.extra.prob_start
            if card.ability.extra.prob_current >= (card.ability.extra.prob_mod) then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "prob_current",
                    scalar_value = "prob_mod",
                    operation = "-",
                    no_message = true
                })
            else
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex"),
                }
            end
        end
    end
}