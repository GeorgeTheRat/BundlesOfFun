BundlesOfFun.Joker {
    key = "manqian",
    name = "Manqian",
    bundle = "fables",
    pos = { x = 1, y = 6 },
    soul_pos = { x = 1, y = 7 },
    attributes = { "xmult", "hand_type" },
    cost = 20,
    rarity = 4,
    unlocked = false,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local most_played = 0
        local most_played_hand
        for hand, data in pairs(G.GAME.hands) do
            if data.played > most_played then
                most_played = data.played
                most_played_hand = hand
            end
        end
        local hand_level = most_played_hand ~= nil and G.GAME.hands[most_played_hand].level or 0
        local hand_name = most_played_hand ~= nil and localize(most_played_hand, "poker_hands") or "None"
        local colour = (hand_level <= 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, hand_level)])
        return {
            vars = {
                hand_name,
                hand_level,
                colours = { colour }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local most_played = 0
            local most_played_hand = "High Card"
            for hand, data in pairs(G.GAME.hands) do
                if data.played > most_played then
                    most_played = data.played
                    most_played_hand = hand
                end
            end
            local hand_level = most_played_hand ~= nil and G.GAME.hands[most_played_hand].level or 1
            return {
                xmult = hand_level
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    border_nodes = {
                        {
                            ref_table = "card.joker_display_values",
                            ref_value = "hand_level",
                            signed = "X",
                            retrigger_type = "^"
                        }
                    }
                }
            },
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "most_played_hand", colour = G.C.FILTER },
                { text = ")" }
            },
            calc_function = function(card)
                local most_played = 0
                local most_played_hand
                for hand, data in pairs(G.GAME.hands) do
                    if data.played > most_played then
                        most_played = data.played
                        most_played_hand = hand
                    end
                end
                local hand_level = most_played_hand ~= nil and G.GAME.hands[most_played_hand].level or 1
                local hand_name = most_played ~= 0 and localize(most_played_hand, "poker_hands") or "None"
                card.joker_display_values.hand_level = hand_level
                card.joker_display_values.most_played_hand = hand_name
            end
        }
    end
}