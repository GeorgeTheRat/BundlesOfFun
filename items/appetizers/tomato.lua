SMODS.Joker {
    key = "a_tomato",
    name = "Tomato",
    config = {
        extra = {
            amount = 15,
            odds = 3,
            change = false
        }
    },
    pos = { x = 4, y = 0 },
    cost = 1,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'bof_a_tomato')
        local cae = card.ability.extra
        return {
            vars = {
                cae.amount, numerator, denominator
            }
        }
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.individual and context.cardarea == G.hand and SMODS.pseudorandom_probability(card, "bof_a_tomato", 1, cae.odds ) and not context.end_of_round and context.other_card.ability.set == "Default" then 
            if context.other_card and cae.amount > 0 then
                cae.change = true
                cae.amount = cae.amount - 1
                context.other_card:juice_up()
                context.other_card:set_ability(pseudorandom_element({"m_mult","m_lucky"}, pseudoseed("bof_a_tomato")))
            end
        end
        
        if context.final_scoring_step and not context.blueprint and cae.change then
            if cae.amount <= 0 then
                SMODS.destroy_cards(card)
                return{
                    message = localize("k_eaten_ex"),
                    message_card = card
                }
            else
                cae.change = false
                return{
                    message = tostring(cae.amount)
                }
            end
        end
    end
}