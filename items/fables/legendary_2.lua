SMODS.Joker {
    key = "f_manqian",
    name = "ManQian",
    pos = { x = 0, y = 0 },
    cost = 20,
    rarity = 4,
    -- order = 0,
    blueprint_compat = true,
    atlas = "placeholder",
    calculate = function(self, card, context)
        if context.initial_scoring_step then
            return {
                xmult = $most_played_hand_level
            }
        end
    end
}