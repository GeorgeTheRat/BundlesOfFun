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
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "bof_a_tomato")
        return {
            vars = {
                card.ability.extra.amount,
                numerator,
                denominator
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and SMODS.pseudorandom_probability(card, "bof_a_tomato", 1, card.ability.extra.odds) and not context.end_of_round and context.other_card.ability.set == "Default" then 
            if context.other_card and card.ability.extra.amount > 0 then
                card.ability.extra.change = true
                card.ability.extra.amount = card.ability.extra.amount - 1
                context.other_card:juice_up()
                context.other_card:set_ability(pseudorandom_element({ "m_mult", "m_lucky" }, pseudoseed("bof_a_tomato")))
            end
        end
        
        if context.final_scoring_step and not context.blueprint and card.ability.extra.change then
            if card.ability.extra.amount <= 0 then
                SMODS.destroy_cards(card)
                return {
                    message = localize("k_eaten_ex"),
                    message_card = card
                }
            else
                card.ability.extra.change = false
                return {
                    message = tostring(card.ability.extra.amount)
                }
            end
        end
    end
}