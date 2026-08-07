BundlesOfFun.Joker {
    key = "satanist",
    name = "Satanist",
    bundle = "jesters",
    pos = { x = 9, y = 5 },
    attributes = { "six", "retrigger" },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local six_count = 0
            for _, c in ipairs(G.play.cards) do
                if c.base.id == 6 then
                    six_count = six_count + 1
                end
            end
            if six_count > 0 and context.other_card.base.id ~= 6 then
                return {
                    repetitions = six_count
                }
            end
        end
    end
}