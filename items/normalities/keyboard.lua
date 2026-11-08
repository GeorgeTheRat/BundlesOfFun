BundlesOfFun.Joker {
    key = "keyboard",
    name = "Keyboard",
    bundle = "normalities",
    config = { extra = { mult = 8 } },
    pos = { x = 5, y = 5 },
    attributes = { "mult", "rank", "eight" },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local eight_tally = 0
        if BOF.nc(G.deck, "cards") then
            for _, playing_card in ipairs(G.deck.cards) do
                if playing_card:get_id() == 8 then eight_tally = eight_tally + 1 end
            end
        end
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.mult * eight_tally
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 8 then
                local eight_tally = 0
                if BOF.nc(G.deck, "cards") then
                    for _, playing_card in ipairs(G.deck.cards) do
                        if playing_card:get_id() == 8 then eight_tally = eight_tally + 1 end
                    end
                end
                if eight_tally > 0 then
                    return {
                        mult = card.ability.extra.mult * eight_tally
                    }
                end
            end
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
            calc_function = function(card)
                local eight_tally = 0
                if BOF.nc(G.deck, "cards") then
                    for _, playing_card in ipairs(G.deck.cards) do
                        if playing_card:get_id() == 8 then eight_tally = eight_tally + 1 end
                    end
                end
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                local mult = 0
                if text ~= "Unknown" and eight_tally > 0 then
                    for _, scoring_card in pairs(scoring_hand) do
                        if scoring_card:get_id() == 8 then
                            mult = mult + card.ability.extra.mult * eight_tally * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        end
                    end
                end
                card.joker_display_values.mult = mult
            end
        }
    end
}