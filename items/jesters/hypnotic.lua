BundlesOfFun.Joker {
    key = "hypnotic",
    name = "Hypnotic Joker",
    bundle = "jesters",
    config = {
        extra = {
            hand_size = 3,
            count = 5,
            previous_has_five = nil
        }
    },
    pos = { x = 2, y = 6 },
    attributes = { "hand_type" },
    cost = 8,
    rarity = 3,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hand_size,
                card.ability.extra.count
            }
        }
    end,
    calculate = function(self, card, context)
        local most_played = 0
        local most_played_hand = "High Card"
        local most_played_count = math.huge
        for hand, data in pairs(G.GAME.hands) do
            local true_count = 0
            for _, hand_card in ipairs(data.example) do
                if hand_card[2] == true then
                    true_count = true_count + 1
                end
            end
            if data.played > most_played then
                most_played = data.played
                most_played_hand = hand
                most_played_count = true_count
            elseif data.played == most_played and true_count < most_played_count then
                most_played_hand = hand
                most_played_count = true_count
            end
        end
        local current_has_five = false
        local example = G.GAME.hands[most_played_hand].example
        local true_count = 0
        for _, hand_card in ipairs(example) do
            if hand_card[2] == true then
                true_count = true_count + 1
            end
        end
        if true_count == card.ability.extra.count then
            current_has_five = true
        end
        if card.ability.extra.previous_has_five == nil then
            card.ability.extra.previous_has_five = current_has_five
        end
        if current_has_five ~= card.ability.extra.previous_has_five then
            card.ability.extra.previous_has_five = current_has_five
            if current_has_five then
                G.hand:change_size(card.ability.extra.hand_size)
                card_eval_status_text(card, "extra", nil, nil, nil, { message = localize({ type = "variable", key = "a_handsize", vars = { card.ability.extra.hand_size } }) })
            else
                G.hand:change_size(-card.ability.extra.hand_size)
                card_eval_status_text(card, "extra", nil, nil, nil, { message = localize({ type = "variable", key = "a_handsize_minus", vars = { card.ability.extra.hand_size } }) })
            end
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "hand_size" },
            },
            text_config = { colour = G.C.FILTER },
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "most_played_hand" },
                { text = ")" },
            },
            calc_function = function(card)
                local most_played = 0
                local most_played_hand = "High Card"
                local most_played_count = math.huge
                for hand, data in pairs(G.GAME.hands) do
                    local true_count = 0
                    if data.example then
                        for _, hand_card in ipairs(data.example) do
                            if hand_card[2] == true then
                                true_count = true_count + 1
                            end
                        end
                    end
                    if data.played > most_played then
                        most_played = data.played
                        most_played_hand = hand
                        most_played_count = true_count
                    elseif data.played == most_played and true_count < most_played_count then
                        most_played_hand = hand
                        most_played_count = true_count
                    end
                end
                card.joker_display_values.hand_size =
                    most_played_count == card.ability.extra.count
                    and card.ability.extra.hand_size
                    or 0
                card.joker_display_values.most_played_hand = most_played_hand
            end
        }
    end
}