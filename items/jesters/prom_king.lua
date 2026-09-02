BundlesOfFun.Joker {
    key = "prom_king",
    name = "Prom King",
    bundle = "jesters",
    config = { extra = { xmult = 0.5 } },
    pos = { x = 2, y = 3 },
    attributes = { "xmult", "king" },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 13 then
            local queen_count = 0
            for _, played_card in ipairs(context.full_hand) do
                if played_card:get_id() == 12 then
                    queen_count = queen_count + 1
                end
            end
            if G.hand and G.hand.cards then
                for _, hand_card in ipairs(G.hand.cards) do
                    if hand_card:get_id() == 12 then
                        queen_count = queen_count + 1
                    end
                end
            end
            if queen_count > 0 then
                return {
                    xmult = (card.ability.extra.xmult * queen_count) + 1
                }
            end
        end
    end,
joker_display_def = function(JokerDisplay)
    return {
        text = {
            {
                border_nodes = {
                    { text = "X" },
                    { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "xmult" }
                }
            }
        },
        calc_function = function(card)
            local queen_count = 0
            local text, _, scoring_hand = JokerDisplay.evaluate_hand()
            if text ~= "Unknown" then
                for _, played_card in ipairs(G.play.cards) do
                    if played_card:get_id() == 12 then
                        queen_count = queen_count + JokerDisplay.calculate_card_triggers(played_card, scoring_hand)
                    end
                end
                if G.hand and G.hand.cards then
                    for _, hand_card in ipairs(G.hand.cards) do
                        if hand_card:get_id() == 12 then
                            queen_count = queen_count + JokerDisplay.calculate_card_triggers(hand_card, nil, true)
                        end
                    end
                end
                local king_count = 0
                for _, scoring_card in pairs(scoring_hand) do
                    if scoring_card:get_id() == 13 then
                        king_count = king_count + 1
                    end
                end
                local xmult = (card.ability.extra.xmult * queen_count) + 1
                card.joker_display_values.xmult = xmult ^ king_count
            else
                card.joker_display_values.xmult = 1
            end
        end
    }
end
}