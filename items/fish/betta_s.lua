BundlesOfFun.Consumable {
    key = "betta_s",
    name = "Betta Small",
    bundle = "fish",
    set = "Fish",
    pools = { ["fish_s"] = true },
    pos = { x = 3, y = 0 },
    config = {
        card_limit = 1,
        extra = {
            mult = 4,
            rounds_remaining = 2
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.card_limit,
                card.ability.extra.rounds_remaining
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.end_of_round and context.main_eval and not context.repetition then
            if card.ability.extra.rounds_remaining > 1 then
                card.ability.extra.rounds_remaining = card.ability.extra.rounds_remaining - 1
                return {
                    message = card.ability.extra.rounds_remaining .. ""
                }
            else
                SMODS.destroy_cards(card, { pinch_anim = true })
                return {
                    message = localize("k_eaten_ex")
                }
            end
        end
    end
}