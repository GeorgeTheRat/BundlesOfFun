BundlesOfFun.Joker {
    key = "glue",
    name = "Glue",
    bundle = "fables",
    config = {
        extra = {
            mult = 0,
            mult_mod = 3
        }
    },
    pos = { x = 4, y = 6 },
    soul_pos = { x = 4, y = 7 },
    attributes = { "mult", "scaling", "enhancements" },
    cost = 20,
    rarity = 4,
    unlocked = false,
    blueprint_compat = true,
    perishable_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.mult_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.discard and not context.other_card.debuff and next(SMODS.get_enhancements(context.other_card)) and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "mult_mod",
                message_colour = G.C.MULT
            })
        end
        if context.individual and context.cardarea == G.play and next(SMODS.get_enhancements(context.other_card)) then
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
            calc_function = function(card)
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                local count = 0
                if text ~= "Unknown" then
                    for _, scoring_card in pairs(scoring_hand) do
                        if next(SMODS.get_enhancements(scoring_card)) then
                            count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        end
                    end
                end
                card.joker_display_values.mult = card.ability.extra.mult * count
            end
        }
    end
}