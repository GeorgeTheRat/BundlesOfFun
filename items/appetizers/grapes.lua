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
    atlas = "joker",
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
        if context.end_of_round and not context.game_over and context.main_eval and context.beat_boss and not context.blueprint then
            SMODS.calculate_effect({message = localize("k_eaten_ex")}, card)
            SMODS.destroy_cards(card, true, true, true)
        end
    end
}
