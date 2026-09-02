BundlesOfFun.Joker {
    key = "melon",
    name = "Royal Melon",
    bundle = "appetizers",
    config = {
        extra = {
            count = 25,
            sell_cost_mod = 3
        }
    },
    pos = { x = 11, y = 0 },
    attributes = { "face", "economy", "scaling", "sell_value", "food" },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.count,
                card.ability.extra.sell_cost_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and (context.cardarea == G.play or context.cardarea == "unscored") and context.other_card:is_face() and not card.ability.extra.eaten then
            local scored, last_use = context.cardarea == G.play, card.ability.extra.count <= 1
            card.ability.extra.face_played = true
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "count",
                operation = "-",
                scalar_table = { 1 },
                scalar_value = 1,
                no_message = true
            })
            if last_use and not context.blueprint then
                card.ability.extra.eaten = true
                return {
                    func = function()
                        SMODS.destroy_cards(card, { pinch_anim = true })
                        SMODS.calculate_effect({ message = localize("k_eaten_ex") }, card)
                    end
                }
            elseif scored then
                card.sell_cost = card.sell_cost + card.ability.extra.sell_cost_mod
                return {
                    func = function()
                        card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_val_up"), colour = G.C.GOLD })
                    end
                }
            end
        end
        if context.after then
            if card.ability.extra.face_played then
                card.ability.extra.face_played = nil
                return {
                    message = card.ability.extra.count .. ""
                }
            end
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+$" },
                { ref_table = "card.joker_display_values", ref_value = "sell_cost", retrigger_type = "dollars" }
            },
            text_config = { colour = G.C.GOLD },
            reminder_text = {
                { text = "(" },
                { ref_table = "card.ability.extra", ref_value = "count" },
                { text = "/" },
                { ref_table = "card.joker_display_values", ref_value = "start_count_melon" },
                { text = ")" },
            },
            reminder_text_config = { scale = 0.35 },
            calc_function = function(card)
                local sell_cost = 0
                local _, _, scoring_hand = JokerDisplay.evaluate_hand()
                if scoring_hand then
                    local face_cards = 0
                    for _, scoring_card in pairs(scoring_hand) do
                        if scoring_card:is_face() then
                            face_cards = face_cards + 1
                        end
                    end
                    sell_cost = math.min(face_cards, card.ability.extra.count) * card.ability.extra.sell_cost_mod
                end
                card.joker_display_values.sell_cost = sell_cost
                card.joker_display_values.start_count_melon = card.joker_display_values.start_count_melon or card.ability.extra.count
            end,
            style_function = function(card, text, reminder_text, extra)
                local children = reminder_text and reminder_text.children
                if not children then
                    return
                end
                local colour = (card.ability.extra.count == 1) and G.C.RED or G.C.UI.TEXT_INACTIVE
                for i = 2, 4 do
                    local child = children[i]
                    if child then child.config.colour = colour end
                end
            end
        }
    end
}