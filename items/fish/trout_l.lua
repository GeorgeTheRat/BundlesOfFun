SMODS.Consumable {
    key = "i_trout_l",
    name = "Rainbow Trout Legendary",
    set = "Fish",
    pools = { ["fish_l"] = true },
    pos = { x = 2, y = 1 },
    config = {
        extra = {
            xmult = 1.25,
            slots = 1
        }
    },
    cost = 20,
    hidden = true,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.slots
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
        if context.other_joker or (context.other_consumeable and context.other_consumeable ~= card) then
            return {
                xmult = card.ability.extra.xmult
            }
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