SMODS.Joker {
    key = "j_tumor_tom",
    name = "Tumor Tom",
    config = {
        extra = {
            joker_slots = 2,
            old = 0
        },
        card_limit = 2
    },
    pos = { x = 9, y = 1 },
    cost = 7,
    rarity = 3,
    order = 13,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.joker_slots
            }
        }
    end,
    add_to_deck = function(self, card, context)
        card.ability.extra.old = G.consumeables.config.card_limit
        G.consumeables.config.card_limit = 0
    end,
    remove_from_deck = function(self, card, context)
        card.ability.extra.old = card.ability.extra.old
        G.consumeables.config.card_limit =  G.consumeables.config.card_limit + card.ability.extra.old
    end
}