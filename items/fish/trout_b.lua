BundlesOfFun.Consumable {
    key = "trout_b",
    name = "Rainbow Trout Big",
    bundle = "fish",
    set = "Fish",
    pools = { ["fish_b"] = true },
    pos = { x = 1, y = 1 },
    config = {
        card_limit = 1,
        extra = {
            xmult = 1.5,
            rounds_remaining = 3
        }
    },
    cost = 6,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.card_limit,
                card.ability.extra.rounds_remaining
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
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