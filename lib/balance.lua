-- register custom calculation key for balance effect
table.insert(SMODS.calculation_keys, "bof_balance_percent")
if SMODS.other_calculation_keys then
    table.insert(SMODS.other_calculation_keys, "bof_balance_percent")
end 

-- track color mixing state and original function
local bof_balance_mixed = false
local bof_original_smods_calculate_effect = SMODS.calculate_individual_effect

-- balance chips and mult towards their average
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

-- handle balance percent calculation with visual effects
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
    if key ~= "bof_balance_percent" then
        return bof_original_smods_calculate_effect(effect, scored_card, key, amount, from_edition)
    end
    if amount > 100 then
        amount = 100
    end
    if effect.card and effect.card ~= scored_card then
        juice_card(effect.card)
    end
    local new_hand_chips, new_mult = calculate_balance_percent_values(hand_chips, mult, amount / 100)
    SMODS.Scoring_Parameters.chips:modify(new_hand_chips - hand_chips)
    SMODS.Scoring_Parameters.mult:modify(new_mult - mult)
    local text = "Balanced " .. amount .. "%"
    
    -- apply plasma color effect with vanilla sounds
    G.E_MANAGER:add_event(Event({
        func = function()
            local pitch = 1 + (amount / 100 - 1) * 0.3
            play_sound("gong", 0.94 * pitch, 0.3)
            play_sound("gong", 0.94 * 1.5 * pitch, 0.2)
            play_sound("tarot1", 1.5)
            ease_colour(G.C.UI_CHIPS, mix_colours(G.C.PLASMA, G.C.UI_CHIPS, amount / 100))
            ease_colour(G.C.UI_MULT, mix_colours(G.C.PLASMA, G.C.UI_MULT, amount / 100))
            if not bof_balance_mixed then
                bof_balance_mixed = true
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    blockable = false,
                    blocking = false,
                    delay = 0.8,
                    func = function()
                        ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.8)
                        ease_colour(G.C.UI_MULT, G.C.RED, 0.8)
                        return true
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    blockable = false,
                    blocking = false,
                    no_delete = true,
                    delay = 1.3,
                    func = function()
                        G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                        G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                        bof_balance_mixed = false
                        return true
                    end
                }))
            end
            return true
        end
    }))
    if not effect.remove_default_message then
        if from_edition then
            card_eval_status_text(scored_card, "jokers", nil, amount / 100, nil, {
                message = text,
                colour = G.C.PLASMA,
                edition = true
            })
        else
            card_eval_status_text(
                effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, "extra", nil, amount / 100, nil, {
                    message = text,
                    colour = G.C.PLASMA
                }
            )
        end
    end
    delay(0.6)
    return true
end