SMODS.Joker {
    key = "j_furious",
    name = "Furious Joker",
    config = { extra = { dollars = 8 } },
    pos = { x = 4, y = 3 },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.modifiers.no_interest = true
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.modifiers.no_interest = false
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end
}