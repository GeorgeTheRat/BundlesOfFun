SMODS.Joker {
    key = "j_tom",
    name = "Tumor Tom",
    config = {
        card_limit = 2,
        extra = { consumable_slots = 2 }
    },
    pos = { x = 9, y = 1 },
    cost = 7,
    rarity = 3,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.card_limit,
                card.ability.extra.consumable_slots
            }
        }
    end,
    add_to_deck = function(self, card, context)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.consumable_slots
    end,
    remove_from_deck = function(self, card, context)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.consumable_slots
    end
}