BundlesOfFun.Consumable {
    key = "blob_b",
    name = "Blobfish Big",
    bundle = "fish",
    set = "Fish",
    pools = { ["fish_b"] = true },
    pos = { x = 7, y = 1 },
    config = {
        card_limit = 1,
        extra = { rounds_remaining = 2 }
    },
    cost = 6,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.card_limit,
                card.ability.extra.rounds_remaining
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card {
                            set = "Tarot",
                            key_append = "bof_blob_b"
                        }
                        return true
                    end
                }))
                return {
                    message = localize("k_plus_tarot"),
                    colour = G.C.SECONDARY_SET.Tarot
                }
            end
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