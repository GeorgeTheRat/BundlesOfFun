SMODS.Consumable {
    key = "i_betta_b",
    name = "Betta Big",
    set = "Fish",
    pools = { ["fish_b"] = true },
    pos = { x = 4, y = 0 },
    config = {
        extra = {
            mult = 10,
            slots = 1,
            rounds_remaining = 3
        }
    },
    cost = 6,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.slots,
                card.ability.extra.rounds_remaining
            }
        }
    end,
    add_to_deck = function(self, card, deck)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
                return true
            end
        }))
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
                    message = card.ability.extra.rounds_remaining .. " Rounds Remaining!"
                }
            else
                SMODS.destroy_cards(card, true, true, true)
                return {
                    message = localize("k_eaten_ex")
                }
            end
        end
    end,
    remove_from_deck = function(self, card, deck)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
                return true
            end
        }))
    end
}