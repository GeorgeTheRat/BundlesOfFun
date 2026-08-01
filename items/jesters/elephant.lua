BundlesOfFun.Joker {
    key = "elephant",
    name = "Elephant",
    bundle = "jesters",
    config = { extra = { chips = 90 } },
    pos = { x = 0, y = 5 },
    attributes = { "chips" },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local all_same_rank = true
            local first_rank = context.full_hand[1].base.value
            for _, c in ipairs(context.full_hand) do
                if c.base.value ~= first_rank then
                    all_same_rank = false
                    break
                end
            end
            if all_same_rank then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}