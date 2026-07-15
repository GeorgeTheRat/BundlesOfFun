SMODS.Blind {
    key = "change",
    name = "The Change",
    bundle = "enemies",
    pos = { y = 3 },
    atlas = "blind",
    boss = { min = 4 },
    boss_colour = HEX("6499a4"),
    stay_flipped = function(self, area, card)
        if area == G.hand then
            return next(SMODS.get_enhancements(card))
        end
        return false
    end
}