BundlesOfFun.Joker {
    key = "jim",
    name = "Slim Jim",
    bundle = "jesters",
    config = {
        extra = {
            hands = 1,
            discards = 1,
            hand_size = -1
        }
    },
    pos = { x = 0, y = 1 },
    pixel_size = { w = 65 },
    attributes = { "hands", "discard", "hand_size", "passive" },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
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
        ease_discard(card.ability.extra.discards)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_hands_played(card.ability.extra.hands)
        G.hand:change_size(card.ability.extra.hand_size)
    end,
    remove_from_deck = function(self, card, context)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
        ease_discard(-card.ability.extra.discards)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        ease_hands_played(-card.ability.extra.hands)
        G.hand:change_size(-card.ability.extra.hand_size)
    end
}