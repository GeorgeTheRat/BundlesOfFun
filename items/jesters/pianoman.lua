BundlesOfFun.Joker {
    key = "pianoman",
    name = "Pianoman",
    bundle = "jesters",
    pos = { x = 9, y = 5 },
    cost = 9,
    rarity = 3,
    blueprint_compat = false,
    atlas = "joker",
    attributes = { "passive", "jokers" },
    add_to_deck = function(self, card, deck)
        G.GAME.bof_pianoman_common_only = true
        G.GAME.bof_pianoman_unlimited_boosters = true
    end,
    remove_from_deck = function(self, card, deck)
        G.GAME.bof_pianoman_common_only = false
        G.GAME.bof_pianoman_unlimited_boosters = false
    end
}