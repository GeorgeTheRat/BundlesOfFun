-- enhanced cards are drawn face down
BundlesOfFun.Blind {
    key = "change",
    name = "The Change",
    bundle = "enemies",
    pos = { y = 3 },
    atlas = "blind",
    boss = { min = 4 },
    boss_colour = HEX("6499a4"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        -- keep face down any enhanced card entering the hand
        if context.stay_flipped and context.to_area == G.hand then
            if next(SMODS.get_enhancements(context.other_card)) then
                return { stay_flipped = true }
            end
        end
    end
}
