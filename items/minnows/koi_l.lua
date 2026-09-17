BundlesOfFun.Consumable {
    key = "koi_l",
    name = "Koi Legendary",
    bundle = "minnows",
    set = "Fish",
    soul_set = "Fish",
    pools = { ["fish_l"] = true },
    pos = { x = 4, y = 2 },
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
                balance = true
            }
        end
    end
}