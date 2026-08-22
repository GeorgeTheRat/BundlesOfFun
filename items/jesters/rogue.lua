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
                { ref_table = "card.joker_display_values", ref_value = "dollars", colour = G.C.GOLD }
            },
            text_config = { colour = G.C.GOLD },
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
            end
        }
    end
}