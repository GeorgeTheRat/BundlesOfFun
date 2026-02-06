SMODS.Joker {
    key = "f_legendary_2",
    name = "Placeholder",
    pos = { x = 0, y = 0 },
    cost = 20,
    rarity = 4,
    -- order = 0,
    blueprint_compat = true,
    atlas = "placeholder",
    calculate = function(self, card, context)
        if context.initial_scoring_step then
            return {
                xchips = mult
            }
        end
    end
}