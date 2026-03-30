SMODS.Joker {
    key = "a_leek",
    name = "Jelly Beans",
    config = {
        extra = {
            probabilities_start = 3.9,
            probabilities_current = nil,
            decrease = 0.1
        }
    },
    pos = { x = 8, y = 0 },
    cost = 3,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        if not card.ability.extra.probabilities_current then
            card.ability.extra.probabilities_current = card.ability.extra.probabilities_start 
        end
        return { vars = { card.ability.extra.probabilities_start, card.ability.extra.decrease, card.ability.extra.probabilities_current } }
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.mod_probability and not context.blueprint then
            card.ability.extra.probabilities_current = card.ability.extra.probabilities_current or card.ability.extra.probabilities_start
            return {
                numerator = context.numerator + cae.probabilities_current
            }
        end
        if context.pseudorandom_result and context.result then
           card.ability.extra.probabilities_current = card.ability.extra.probabilities_current or card.ability.extra.probabilities_start
            if cae.probabilities_current >= (cae.decrease) then
                SMODS.scale_card(card, {
                    ref_table = cae,
                    ref_value = "probabilities_current",
                    scalar_value = "decrease",
                    operation = "-",
                    scaling_message = {
                        message = localize("k_bof_downgrade"),
                        colour = G.C.RED
                    }
                })
                else
                    SMODS.destroy_cards(card, nil, nil, true)
                    return{
                        message = localize('k_eaten_ex'),
                    }
                end
         
        end
    end
}