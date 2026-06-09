SMODS.Joker {
    key = "a_grapes",
    name = "Grapes",
    config = {
        extra = {
            chips = 100,
            mult = 25,
            xmult = 3
        }
    },
    pos = { x = 7, y = 0 },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = "joker",
    attributes = { "mult", "chips", "xmult", "boss_blind", "food" },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                extra = {
                    mult = card.ability.extra.mult,
                    extra = {
                        xmult = card.ability.extra.xmult
                    }
                }
            }
        end
        if context.beat_boss and context.main_eval and not context.blueprint then
            SMODS.destroy_cards(card, nil, true, true)
            return {
                message = localize("k_eaten_ex")
            }
        end
    end
}