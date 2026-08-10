BundlesOfFun.Joker {
    key = "prom_queen",
    name = "Prom Queen",
    bundle = "jesters",
    config = { extra = { chips = 50 } },
    pos = { x = 3, y = 5 },
    attributes = { "chips", "queen" },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:get_id() == 12 then
            local king_count = 0
            for _, played_card in ipairs(context.full_hand) do
                if played_card:get_id() == 13 then
                    king_count = king_count + 1
                end
            end
            if G.hand and G.hand.cards then
                for _, hand_card in ipairs(G.hand.cards) do
                    if hand_card:get_id() == 13 then
                        king_count = king_count + 1
                    end
                end
            end
            if king_count > 0 then
                return {
                    chips = card.ability.extra.chips * king_count
                }
            end
        end
    end
}