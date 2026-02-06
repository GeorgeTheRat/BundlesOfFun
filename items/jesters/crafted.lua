SMODS.Joker {
    key = "j_crafted",
    name = "Crafted Joker",
    pos = { x = 5, y = 2 },
    cost = 5,
    rarity = 2,
    order = 33,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.skip_blind then
            ease_dollars(G.GAME.round)
            SMODS.destroy_cards(card, nil, nil, true)
        end
    end
}
