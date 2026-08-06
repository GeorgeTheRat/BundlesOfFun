-- played hand must contain at least 4 scoring cards
-- (works like The Psychic - debuffs the whole hand instead of preventing the play)
BundlesOfFun.Blind {
    key = "square",
    name = "The Square",
    bundle = "enemies",
    pos = { y = 22 },
    atlas = "blind",
    boss = { min = 0 },
    boss_colour = HEX("b89898"),
    calculate = function(self, blind, context)
        -- context.scoring_hand only has the cards that actually form the scored hand
        if not blind.disabled and context.debuff_hand then
            if not context.scoring_hand or #context.scoring_hand < 4 then
                return {
                    debuff = true
                }
            end
        end
    end,
    get_loc_debuff_text = function(self)
        return localize("bl_bof_square")
    end
}