SMODS.Joker {
    key = "a_tomato",
    name = "Tomato",
    config = {
        extra = {
            amount = 20,
            odds = 2,
            change = false
        }
    },
    pos = { x = 4, y = 0 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
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
        if
            context.individual and
            context.cardarea == G.hand and
            not context.end_of_round
        then
            if context.other_card and card.ability.extra.amount > 0 then
                card.ability.extra.change = true
                card.ability.extra.amount = card.ability.extra.amount - 1
                if SMODS.pseudorandom_probability(card, "bof_a_tomato", 1, card.ability.extra.odds) then
                    card:juice_up()
                    context.other_card:juice_up()
                    context.other_card:set_ability(pseudorandom_element({ "m_mult", "m_lucky" }, pseudoseed("bof_a_tomato")))
                end
            end
        end
        if context.final_scoring_step and not context.blueprint and card.ability.extra.change then
            if card.ability.extra.amount <= 0 then
                SMODS.destroy_cards(card, nil, true, true)
                return {
                    message = localize("k_eaten_ex")
                }
            end
        end
    end
}