BundlesOfFun.Joker {
    key = "prom_queen",
    name = "Prom Queen",
    bundle = "jesters",
    config = { extra = { chips = 50 } },
    pos = { x = 3, y = 3 },
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
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "chips" }
            },
            text_config = { colour = G.C.CHIPS },
            calc_function = function(card)
                local king_count = 0
                local queen_count = 0
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                if text ~= "Unknown" then
                    for _, played_card in ipairs(G.play.cards) do
                        if played_card:get_id() == 13 then
                            king_count = king_count + JokerDisplay.calculate_card_triggers(played_card, scoring_hand)
                        end
                    end
                    if G.hand and G.hand.cards then
                        for _, hand_card in ipairs(G.hand.cards) do
                            if hand_card:get_id() == 13 then
                                king_count = king_count + JokerDisplay.calculate_card_triggers(hand_card, nil, true)
                            elseif hand_card:get_id() == 12 then
                                queen_count = queen_count + 1
                            end
                        end
                    end
                    card.joker_display_values.chips = card.ability.extra.chips * king_count * queen_count
                else
                    card.joker_display_values.chips = 0
                end
            end
        }
    end
}