BundlesOfFun.Joker {
    key = "director",
    name = "Director",
    bundle = "jesters",
    config = { extra = { xmult = 1.25 } },
    pos = { x = 5, y = 4 },
    attributes = { "xmult", "retrigger" },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.retrigger_joker_check and context.other_card == card then
            local count = 0
            if G.play.cards and next(G.play.cards) then
                for k, v in pairs(G.play.cards) do
                    if v.bof_retriggered then
                        count = count + 1
                    end
                end
                return {
                    repetitions = count
                }
            end
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            -- effective xmult, accounting for Director's own repetitions: xmult is reapplied
            -- once per played card that would retrigger (mirrors the bof_retriggered count in
            -- calculate). JokerDisplay.calculate_card_triggers is the pre-play equivalent of the
            -- SMODS.calculate_repetitions hook that sets bof_retriggered, so it's used here to
            -- predict the same count before the hand actually resolves.
            text = {
                {
                    border_nodes = {
                        { text = "X" },
                        { ref_table = "card.joker_display_values", ref_value = "xmult" }
                    }
                }
            },
            calc_function = function(card)
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                local retriggered_count = 0
                if text ~= "Unknown" then
                    for _, scoring_card in pairs(scoring_hand) do
                        if JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand) >= 2 then
                            retriggered_count = retriggered_count + 1
                        end
                    end
                end
                card.joker_display_values.xmult = card.ability.extra.xmult ^ (1 + retriggered_count)
            end
        }
    end
}