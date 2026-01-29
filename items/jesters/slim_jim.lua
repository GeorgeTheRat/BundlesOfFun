SMODS.Joker {
    key = "j_slim_jim",
    name = "Slim Jim",
    config = {
        extra = {
            hands = 1,
            discards = 1,
            hand_size = -2
        }
    },
    pos = { x = 0, y = 1 },
    cost = 6,
    rarity = 2,
    order = 24,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hands,
                card.ability.extra.discards,
                card.ability.extra.hand_size
            }
        }
    end,
    add_to_deck = function(self, card, context)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        G.hand:change_size(card.ability.extra.hand_size)
    end,
    remove_from_deck = function(self, card, context)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        G.hand:change_size(-card.ability.extra.hand_size)
    end
}