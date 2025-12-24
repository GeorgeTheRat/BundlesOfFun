table.insert(SMODS.calculation_keys, "bof_balance_percent")
if SMODS.other_calculation_keys then
    table.insert(SMODS.other_calculation_keys, "bof_balance_percent")
end

local bof_balance_mixed = false
local bof_original_smods_calculate_effect = SMODS.calculate_individual_effect

function calculate_balance_percent_values(input_hand_chips, input_mult, percent)
    local chip_mod = percent * input_hand_chips
    local mult_mod = percent * input_mult
    local avg = (chip_mod + mult_mod) / 2
    local new_hand_chips = input_hand_chips + (avg - chip_mod)
    local new_mult = input_mult + (avg - mult_mod)

    new_hand_chips = math.floor(new_hand_chips + 0.5)
    new_mult = math.floor(new_mult + 0.5)

    new_hand_chips = math.max(1, new_hand_chips)
    new_mult = math.max(1, new_mult)

    return new_hand_chips, new_mult
end

SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
    if key ~= "bof_balance_percent" then
        return bof_original_smods_calculate_effect(effect, scored_card, key, amount, from_edition)
    end

    if amount > 1 then
        amount = 1
    end

    if effect.card and effect.card ~= scored_card then
        juice_card(effect.card)
    end

    local new_hand_chips, new_mult = calculate_balance_percent_values(hand_chips, mult, amount)

    SMODS.Scoring_Parameters.chips:modify(new_hand_chips - hand_chips)
    SMODS.Scoring_Parameters.mult:modify(new_mult - mult)

    local text = "Balanced " .. (amount * 100) .. "%"

    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function()
            ease_colour(G.C.UI_CHIPS, mix_colours({ 0.8, 0.45, 0.85, 1 }, G.C.UI_CHIPS, amount))
            ease_colour(G.C.UI_MULT, mix_colours({ 0.8, 0.45, 0.85, 1 }, G.C.UI_MULT, amount))

            if not bof_balance_mixed then
                bof_balance_mixed = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    blockable = false,
                    blocking = false,
                    delay = 6.3,
                    func = (function()
                        if G.STATE ~= 2 then
                            ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
                            ease_colour(G.C.UI_MULT, G.C.RED, 2)
                            bof_balance_mixed = false
                            return true
                        end
                    end)
                }))
            end
            return true
        end)
    }))

    if not effect.remove_default_message then
        if from_edition then
            card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {
                message = text,
                colour = { 0.8, 0.45, 0.85, 1 },
                sound = 'gong',
                edition = true
            })
        else
            card_eval_status_text(
                effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, 'extra', nil,
                percent, nil, {
                    message = text,
                    colour = { 0.8, 0.45, 0.85, 1 },
                    sound = 'gong',
                    edition = true
                })
        end
    end

    return true
end
