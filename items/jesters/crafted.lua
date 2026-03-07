SMODS.Joker {
    key = "j_crafted",
    name = "Crafted Joker",
    pos = { x = 5, y = 2 },
    cost = 4,
    rarity = 1,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.skipping_booster then
            ease_dollars(G.GAME.round)
            SMODS.destroy_cards(card, nil, nil, true)
        end
    end
}