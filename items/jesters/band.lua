BundlesOfFun.Joker {
    key = "band",
    name = "One-Man Band",
    bundle = "jesters",
    config = { extra = { mult = 15 } },
    pos = { x = 14, y = 3 },
    attributes = { "mult", "hand_type"},
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.scoring_name == "High Card" then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "mult",
                    signed = true,
                    retrigger_type = "*",
                    colour = G.C.MULT
                }
            },
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.FILTER },
                { text = ")" },
            },
            calc_function = function(card)
                local hand_name, _, scoring_hand = JokerDisplay.evaluate_hand()
                local mult = 0
                if hand_name == "High Card" then
                    for _, scoring_card in pairs(scoring_hand) do
                        mult = mult + card.ability.extra.mult * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                    end
                end
                card.joker_display_values.mult = mult
                card.joker_display_values.localized_text = localize("High Card", "poker_hands")
            end
        }
    end
}