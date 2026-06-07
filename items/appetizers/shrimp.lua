SMODS.Joker {
    key = "a_shrimp",
    name = "Shrimp",
    config = { extra = { packs = 5 } },
    pos = { x = 7, y = 4 },
    cost = 8,
    rarity = 3,
    eternal_compat = false,
    perishable_compat = false,
    atlas = "joker",
    attributes = { "scaling", "generation", "passive", "food" },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.packs } }
    end
}