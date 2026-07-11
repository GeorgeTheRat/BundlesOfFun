BundlesOfFun.Joker {
    key = "angler",
    name = "Angler",
    bundle = { "jesters", { "fish" } },
    config = {
        extra = {
            chips = 30,
            mult = 6
        }
    },
    pos = { x = 8, y = 5 },
    attributes = { "mult", "chips", "fish" },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local fish_count = 0
        if G.consumeables and G.consumeables.cards then
            for _, consumable in ipairs(G.consumeables.cards) do
                if consumable.ability.set == "Fish" then
                    fish_count = fish_count + 1
                end
            end
        end
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips * fish_count,
                card.ability.extra.mult,
                card.ability.extra.mult * (G.GAME.bof_fish_expired or 0)
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local fish_count = 0
            if G.consumeables and G.consumeables.cards then
                for _, consumable in ipairs(G.consumeables.cards) do
                    if consumable.ability.set == "Fish" then
                        fish_count = fish_count + 1
                    end
                end
            end
            return {
                chips = card.ability.extra.chips * fish_count,
                extra = {
                    mult = card.ability.extra.mult * (G.GAME.bof_fish_expired or 0)
                }
            }
        end
    end
}