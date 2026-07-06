BundlesOfFun.Consumable {
    key = "trout_l",
    name = "Rainbow Trout Legendary",
    bundle = "fish",
    set = "Fish",
    pools = { ["fish_l"] = true },
    pos = { x = 2, y = 1 },
    config = {
        card_limit = 1,
        extra = {
            xmult = 1.25,
            consumable_slots = 0
        }
    },
    cost = 20,
    unlocked = false,
    hidden = true,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.card_limit,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.other_joker or (context.other_consumeable and context.other_consumeable ~= card) then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}