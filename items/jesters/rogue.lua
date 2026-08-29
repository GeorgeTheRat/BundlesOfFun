BundlesOfFun.Joker {
    key = "rogue",
    name = "Rogue",
    bundle = "jesters",
    config = { extra = { dollars = 1 } },
    pos = { x = 5, y = 2 },
    attributes = { "economy", "spades", "clubs" },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and context.end_of_round and (context.other_card:is_suit("Spades") or context.other_card:is_suit("Clubs")) then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            -- mirrors calculate: pays out per Spade/Club card held in hand at end of round.
            -- Cards currently highlighted are about to be played, so they won't be held in hand
            -- unless a hand has already resolved (G.play.cards populated) -- same pattern
            -- JokerDisplay's own vanilla Reserved Parking definition uses for its held-in-hand count.
            text = {
                { text = "+$" },
                { ref_table = "card.joker_display_values", ref_value = "dollars" }
            },
            text_config = { colour = G.C.GOLD },
            reminder_text = {
                { text = "(", colour = G.C.UI.TEXT_INACTIVE },
                { ref_table = "card.joker_display_values", ref_value = "localized_text_1" },
                { text = " or ", colour = G.C.UI.TEXT_INACTIVE },
                { ref_table = "card.joker_display_values", ref_value = "localized_text_2" },
                { text = ")", colour = G.C.UI.TEXT_INACTIVE },
            },
            calc_function = function(card)
                local playing_hand = next(G.play.cards)
                local count = 0
                if G.hand and G.hand.cards then
                    for _, c in ipairs(G.hand.cards) do
                        if (playing_hand or not c.highlighted) and (c:is_suit("Spades") or c:is_suit("Clubs")) then
                            count = count + JokerDisplay.calculate_card_triggers(c, nil, true)
                        end
                    end
                end
                card.joker_display_values.dollars = count * card.ability.extra.dollars
                card.joker_display_values.localized_text_1 = localize("Spades", "suits_plural")
                card.joker_display_values.localized_text_2 = localize("Clubs", "suits_plural")
            end,
            style_function = function(card, text, reminder_text, extra)
                local suit_node_1 = reminder_text and reminder_text.children and reminder_text.children[2]
                local suit_node_2 = reminder_text and reminder_text.children and reminder_text.children[4]
                if suit_node_1 then
                    suit_node_1.config.colour = lighten(G.C.SUITS["Spades"], 0.35)
                end
                if suit_node_2 then
                    suit_node_2.config.colour = lighten(G.C.SUITS["Clubs"], 0.35)
                end
            end
        }
    end
}