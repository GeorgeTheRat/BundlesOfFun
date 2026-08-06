-- halve the sell value of all jokers
BundlesOfFun.Blind {
    key = "useless",
    name = "The Useless",
    bundle = "enemies",
    pos = { y = 14 },
    atlas = "blind",
    boss = { min = 2 },
    boss_colour = HEX("a88878"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        -- guarded so it can't compound if this fires more than once
        if context.setting_blind then
            for _, joker in ipairs(G.jokers.cards) do
                if not joker.ability.bof_useless_halved then
                    joker.ability.bof_useless_halved = true
                    joker.sell_cost = math.floor(joker.sell_cost * 0.5)
                end
            end
        end
    end
}