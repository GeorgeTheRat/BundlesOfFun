BundlesOfFun.Joker {
    key = "cloudy",
    name = "Cloudy Joker",
    bundle = "jesters",
    rarity = 1,
    cost = 4,
    pos = { x = 4, y = 4 },
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = G.GAME.hands[context.scoring_name].chips
            }
        end
    end
}