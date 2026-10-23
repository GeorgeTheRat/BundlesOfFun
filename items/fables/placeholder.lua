BundlesOfFun.Joker {
    key = "placeholder",
    name = "Placeholder",
    bundle = "fables",
    -- pos = { x = 11, y = 6 },
    -- soul_pos = { x = 11, y = 7 },
    attributes = { "retrigger" },
    cost = 20,
    rarity = 4,
    unlocked = false,
    blueprint_compat = true,
    atlas = "placeholder",
    calculate = function(self, card, context)
        if context.repetition then
            return {
                repetitions = (G.consumeables.config.card_limit or 0) - #(G.consumeables.cards or {})
            }
        end
    end
}