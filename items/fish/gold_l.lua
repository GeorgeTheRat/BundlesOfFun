BundlesOfFun.Consumable {
    key = "gold_l",
    name = "Goldfish Legendary",
    bundle = "fish",
    set = "Fish",
    soul_set = "Fish",
    pools = { ["fish_l"] = true },
    pos = { x = 3, y = 2 },
    config = {
        card_limit = 1,
        extra = { consumable_slots = 0 }
    },
    cost = 20,
    unlocked = false,
    hidden = true,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.card_limit } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                dollars = math.min(G.GAME.interest_cap / 5, math.floor(G.GAME.dollars / 5))
            }
        end
    end
}