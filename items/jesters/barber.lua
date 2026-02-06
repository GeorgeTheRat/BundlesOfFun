SMODS.Joker {
    key = "j_barber",
    name = "Barber",
    config = {
        extra = {
            dollars = 1,
            odds = 3,
            dollars_mod = 1,
        }
    },
    pos = { x = 1, y = 2 },
    cost = 5,
    rarity = 1,
    order = 14,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "bof_j_barber")
        return {
            vars = {
                card.ability.extra.dollars,
                numerator,
                denominator,
                card.ability.extra.dollars_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and SMODS.pseudorandom_probability(card, "bof_j_barber", 1, card.ability.extra.odds) then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "dollars",
                scalar_value = "dollars_mod",
                message_colour = G.C.MONEY
            })
        end
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end
}