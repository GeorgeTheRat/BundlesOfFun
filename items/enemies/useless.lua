-- halve the sell value of all jokers
BundlesOfFun.Blind {
    key = "useless",
    name = "The Useless",
    bundle = "enemies",
    pos = { y = 14 },
    attributes = { "economy", "joker", "sell_value" },
    atlas = "blind",
    boss = { min = 2 },
    boss_colour = HEX("a88878"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.setting_blind then
            for _, joker in ipairs(G.jokers.cards) do
                if not joker.ability.bof_useless_halved then
                    joker.ability.bof_useless_halved = true
                    joker.sell_cost = math.max(1, math.floor(joker.sell_cost * 0.5))
                end
            end
        end

        if context.end_of_round then
            for _, joker in ipairs(G.jokers.cards) do
                joker.ability.bof_useless_halved = nil
            end
        end
    end
}