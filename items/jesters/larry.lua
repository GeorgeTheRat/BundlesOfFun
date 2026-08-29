BundlesOfFun.Joker {
    key = "larry",
    name = "Laggard Larry",
    bundle = "jesters",
    config = { extra = { dollars = 3 } },
    pos = { x = 9, y = 3 },
    attributes = { "economy", "hands" },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.before and (G.GAME.current_round.hands_played == 0 or G.GAME.current_round.hands_played == G.GAME.round_resets.hands - 1) then
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            -- mirrors calculate: only fires on the first or last hand of the round
            text = {
                { text = "+$" },
                { ref_table = "card.joker_display_values", ref_value = "dollars", retrigger_type = "dollars" }
            },
            text_config = { colour = G.C.MONEY },
            calc_function = function(card)
                local hands_played = G.GAME.current_round and G.GAME.current_round.hands_played
                local total_hands = G.GAME.round_resets and G.GAME.round_resets.hands
                local active = hands_played and total_hands and (hands_played == 0 or hands_played == total_hands - 1)
                card.joker_display_values.dollars = active and card.ability.extra.dollars or 0
            end
        }
    end
}