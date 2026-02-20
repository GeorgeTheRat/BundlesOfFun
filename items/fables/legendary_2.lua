SMODS.Joker {
    key = "f_manqian",
    name = "ManQian",
    pos = { x = 1, y = 4 },
    soul_pos = { x = 1, y = 5 },
    cost = 20,
    rarity = 4,
    -- order = 0,
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.initial_scoring_step then
            return {
                xmult = $most_played_hand_level
            }
        end
    end
}