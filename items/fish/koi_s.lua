BundlesOfFun.Consumable {
    key = "koi_s",
    name = "Koi Small",
    bundle = "fish",
    set = "Fish",
    pools = { ["fish_s"] = true },
    pos = { x = 4, y = 0 },
    config = {
        card_limit = 1,
        extra = {
            balance_percent = 10,
            rounds_remaining = 2
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.balance_percent,
                card.ability.card_limit,
                card.ability.extra.rounds_remaining
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                bof_balance_percent = card.ability.extra.balance_percent
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
                    message = localize("k_bof_expired")
                }
            end
        end
    end
}