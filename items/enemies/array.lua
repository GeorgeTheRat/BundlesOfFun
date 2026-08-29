-- scoring a card destroys a random consumable
BundlesOfFun.Blind {
    key = "array",
    name = "The Array",
    bundle = "enemies",
    pos = { y = 8 },
    atlas = "blind",
    boss = { min = 2 },
    boss_colour = HEX("789868"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.before then
            local consumables = G.consumeables and G.consumeables.cards
            if not consumables or #consumables == 0 then return end

            local target = pseudorandom_element(consumables, pseudoseed("bof_index"))
            if target then
                target:start_dissolve()
                blind:wiggle()
            end
        end
    end
}