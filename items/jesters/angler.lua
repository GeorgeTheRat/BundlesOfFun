SMODS.Joker {
    key = "j_angler",
    name = "Angler",
    config = {
        extra = {
            chips = 30,
            mult = 6
        }
    },
    pos = { x = 8, y = 5 },
    cost = 6,
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
        local multiplier = fish_count
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.chips * multiplier,
                card.ability.extra.mult * multiplier
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
            local multiplier = fish_count
            return {
                chips = card.ability.extra.chips * multiplier,
                extra = {
                    mult = card.ability.extra.mult * multiplier
                }
            }
        end
    end
}