BundlesOfFun.Joker {
    key = "hooked",
    name = "Hooked Joker",
    bundle = "jesters",
    config = {
        extra = {
            appearance = 1,
            appearance_mod = 1
        }
    },
    pos = { x = 12, y = 3 },
    attributes = { "passive", "economy", "hands" },
    cost = 5,
    rarity = 2,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local fish_count = 0
        if BOF.nc(G.consumeables, "cards") then
            for _, card in ipairs(G.consumeables.cards) do
                if card.ability and card.ability.set == "Fish" then
                    fish_count = fish_count + 1
                end
            end
        end
        return {
            vars = {
                card.ability.extra.appearance + (card.ability.extra.appearance_mod * fish_count),
                card.ability.extra.appearance_mod
            }
        }
    end
    -- main effect is included with the BundlesOfFun.Booster definition
}