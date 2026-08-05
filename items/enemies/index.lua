-- scoring a card destroys a random consumable
BundlesOfFun.Blind {
    key = "index",
    name = "The Index",
    bundle = "enemies",
    pos = { y = 8 },
    atlas = "blind",
    boss = { min = 3 },
    boss_colour = HEX("789868"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        -- per-card individual scoring; first_draft_of_card guards against firing on helper evals
        if context.cardarea == G.play and context.individual and not context.first_draft_of_card then
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
