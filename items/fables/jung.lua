BundlesOfFun.Joker {
    key = "jung",
    name = "Jung",
    bundle = "fables",
    -- pos = { x = 12, y = 6 },
    -- soul_pos = { x = 12, y = 7 },
    config = {
        extra = {
            xmult = 0.2,
            per_dollar = 1
        }
    },
    attributes = { "xmult", "joker" },
    cost = 20,
    rarity = 4,
    unlocked = false,
    blueprint_compat = false,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.per_dollar
            }
        }
    end,
    calculate = function(self, card, context)
        if context.other_joker and context.other_joker ~= card then
            local sell_value = context.other_joker.sell_cost or 0
            if sell_value > 0 then
                return {
                    xmult = 1 + (math.floor(sell_value / card.ability.extra.per_dollar) * card.ability.extra.xmult)
                }
            end
        end
    end
}