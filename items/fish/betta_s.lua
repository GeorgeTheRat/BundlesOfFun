SMODS.Consumable {
    key = "i_betta_s",
    name = "Betta Small",
    set = "Fish",
    pools = { ["fish_s"] = true },
    pos = { x = 3, y = 0 },
    config = {
        extra = {
            mult = 4,
            slots = 1,
            rounds_remaining = 2
        }
    },
    cost = 4,
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
                    message = card.ability.extra.rounds_remaining .. " Round" .. (card.ability.extra.rounds_remaining > 1 and "s" or "") .. " Remaining!"
                }
            else
                SMODS.destroy_cards(card, nil, true, true)
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