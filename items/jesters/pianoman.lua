SMODS.Joker {
    key = "j_pianoman",
    name = "Pianoman",
    pos = { x = 9, y = 5 },
    cost = 9,
    rarity = 3,
    atlas = "joker",
    add_to_deck = function(self, card, deck)
        G.GAME.bof_pianoman_common_only = true
        G.GAME.bof_pianoman_unlimited_boosters = true
    end,
    remove_from_deck = function(self, card, deck)
        G.GAME.bof_pianoman_common_only = false
        G.GAME.bof_pianoman_unlimited_boosters = false
    end
}