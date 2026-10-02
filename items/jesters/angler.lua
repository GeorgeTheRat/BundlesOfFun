BundlesOfFun.Joker {
    key = "angler",
    name = "Angler",
    bundle = { "jesters", { "minnows" } },
    config = {
        extra = {
            chips = 30,
            mult = 4
        }
    },
    pos = { x = 13, y = 2 },
    attributes = { "mult", "chips", "fish" },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local fish_count = 0
        if BOF.nc(G.consumeables, "cards") then
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
            if BOF.nc(G.consumeables, "cards") then
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
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+", colour = G.C.CHIPS },
                { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS },
                { text = " +", colour = G.C.MULT },
                { ref_table = "card.joker_display_values", ref_value = "mult", colour = G.C.MULT }
            },
            calc_function = function(card)
                local fish_count = 0
                if BOF.nc(G.consumeables, "cards") then
                    for _, consumable in ipairs(G.consumeables.cards) do
                        if consumable.ability.set == "Fish" then
                            fish_count = fish_count + 1
                        end
                    end
                end
                card.joker_display_values.chips = card.ability.extra.chips * fish_count
                card.joker_display_values.mult = card.ability.extra.mult * (G.GAME.bof_fish_expired or 0)
            end
        }
    end
}