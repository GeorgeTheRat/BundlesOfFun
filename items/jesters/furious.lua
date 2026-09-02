BundlesOfFun.Joker {
    key = "furious",
    name = "Furious Joker",
    bundle = "jesters",
    config = { extra = { dollars = 8 } },
    pos = { x = 3, y = 2 },
    attributes = { "economy", "passive" },
    cost = 6,
    rarity = 1,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    add_to_deck = function()
        G.GAME.modifiers.no_interest = true
    end,
    remove_from_deck = function()
        G.GAME.modifiers.no_interest = false
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end
}