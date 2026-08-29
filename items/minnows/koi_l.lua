BundlesOfFun.Consumable {
    key = "koi_l",
    name = "Koi Legendary",
    bundle = "fish",
    set = "Fish",
    pools = { ["fish_l"] = true },
    pos = { x = 4, y = 2 },
    config = { card_limit = 1 },
    cost = 20,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.card_limit } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                balance = true
            }
        end
    end
}