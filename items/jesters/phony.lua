BundlesOfFun.Joker {
    key = "phony",
    name = "Phony",
    bundle = "jesters",
    config = {
        extra = {
            mult = 6,
            chips = 10
        },
    },
    pos = { x = 7, y = 2 },
    attributes = { "mult", "chips" },
    cost = 2,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and hand_chips then
            -- make sure chips do not fall into the negatives
            local chips_to_remove = math.min(card.ability.extra.chips, hand_chips - 1)
            return {
                mult = card.ability.extra.mult,
                extra = {
                    chips = -chips_to_remove
                }
            }
        end
    end
}