SMODS.Joker {
    key = "j_henry",
    name = "Handy Henry",
    config = { extra = { extra_hand_bonus = 2 } },
    pos = { x = 3, y = 2 },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.extra_hand_bonus } }
    end,
    add_to_deck = function(self, card, shop)
        G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 1) + card.ability.extra.extra_hand_bonus
    end,
    remove_from_deck = function(self, card)
        G.GAME.modifiers.money_per_hand = math.max(1, (G.GAME.modifiers.money_per_hand or 1) - card.ability.extra.extra_hand_bonus)
    end
}