SMODS.Consumable {
    key = "i_bass_l",
    name = "Largemouth Bass Legendary",
    set = "Fish",
    pools = { ["fish_l"] = true },
    pos = { x = 2, y = 0 },
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
            local total_chips = 0
            if G.playing_cards then
                for i, c in ipairs(G.playing_cards) do
                    total_chips = total_chips + c:get_chip_bonus()
                    if c.ability and c.ability.perma_bonus then
                        total_chips = total_chips + c.ability.perma_bonus
                    end
                end
            end
            return {
                chips = total_chips
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