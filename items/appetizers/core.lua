BundlesOfFun.Joker {
    key = "core",
    name = "Apple Core",
    bundle = "appetizers",
    config = {
        extra = {
            count = 20,
            mult = 8
        }
    },
    pos = { x = 8, y = 0 },
    attributes = { "mult", "scaling", "passive", "food" },
    cost = 1,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.count,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and (context.cardarea == G.play or context.cardarea == "unscored") and not card.ability.extra.eaten then
            local scored, last_use = context.cardarea == G.play, card.ability.extra.count <= 1
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
                    mult = scored and card.ability.extra.mult or nil,
                    message_card = scored and context.other_card or nil,
                    func = function()
                        SMODS.destroy_cards(card, { pinch_anim = true })
                        SMODS.calculate_effect({ message = localize("k_eaten_ex") }, card)
                    end
                }
            elseif scored then
                return {
                    mult = card.ability.extra.mult,
                    message_card = context.other_card,
                }
            end
        end
        if context.after then
            return {
                message = card.ability.extra.count .. ""
            }
        end
        if context.bof_chips_check and card.ability.extra.count > 0 then
            return {
                suppress = true
            }
        end
    end,
    in_pool = function(self, args)
        return false
    end,
    joker_display_def = function(JokerDisplay)
    return {
        text = {
            { text = "+" },
            { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
        },
        text_config = { colour = G.C.MULT },
        reminder_text = {
            { text = "(" },
            { ref_table = "card.ability.extra", ref_value = "count" },
            { text = "/" },
            { ref_table = "card.joker_display_values", ref_value = "start_count_core" },
            { text = ")" },
        },
        reminder_text_config = { scale = 0.35 },
        calc_function = function(card)
            local mult = 0
            local _, _, scoring_hand = JokerDisplay.evaluate_hand()
            if scoring_hand then
                local scoring_cards = math.min(#scoring_hand, card.ability.extra.count)
                mult = scoring_cards * card.ability.extra.mult
            end
            card.joker_display_values.mult = mult
            card.joker_display_values.start_count_core = card.joker_display_values.start_count_core or card.ability.extra.count
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