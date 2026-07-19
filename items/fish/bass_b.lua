BundlesOfFun.Consumable {
    key = "bass_b",
    name = "Largemouth Bass Big",
    bundle = "fish",
    set = "Fish",
    pools = { ["fish_b"] = true },
    pos = { x = 0, y = 1 },
    config = {
        card_limit = 1,
        extra = {
            chips = 50,
            rounds_remaining = 5
        }
    },
    cost = 6,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.card_limit,
                card.ability.extra.rounds_remaining
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
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
                if not card.ability.bof_matey_transforming then
                    return {
                        message = localize("k_bof_expired")
                    }
                end
            end
        end
    end
}