SMODS.Consumable {
    key = "i_goldfish_l",
    name = "Goldfish Legendary",
    set = "Fish",
    pools = { ["fish_l"] = true },
    pos = { x = 5, y = 1 },
    config = { extra = { slots = 1 } },
    cost = 20,
    hidden = true,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.slots } }
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
                dollars = math.min(G.GAME.interest_cap / 5, math.floor(G.GAME.dollars / 5))
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