BundlesOfFun.Joker {
    key = "rummikub",
    name = "Rummikub Tile",
    bundle = "normalities",
    config = {
        extra = { 
            chips_mod = 8,
            chips_threshold = 30,
            chips = 0
        }
    },
    pos = { x = 2, y = 5 },
    attributes = { "chips", "scaling" },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    perishable_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips_mod,
                card.ability.extra.chips_threshold,
                card.ability.extra.chips
            } 
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            local total = 0
            for k, v in pairs(context.scoring_hand) do
                total = total + v.base.nominal + v.ability.bonus + (v.ability.perma_bonus or 0)
            end
            if total >= card.ability.extra.chips_threshold  then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "chips_mod",
                    message_colour = G.C.CHIPS
                })
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    ref_table = "card.ability.extra",
                    ref_value = "chips",
                    signed = true,
                    colour = G.C.CHIPS
                }
            },
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "reminder_text" },
                { text = ")", colour = G.C.UI.TEXT_INACTIVE }
            },
            calc_function = function(card)
                local scoring_chips = 0
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                if text ~= "Unknown" then
                    for _, scoring_card in pairs(scoring_hand) do
                        scoring_chips = scoring_chips + scoring_card.base.nominal + scoring_card.ability.bonus + (scoring_card.ability.perma_bonus or 0)
                    end
                end
                card.joker_display_values.scoring_chips = scoring_chips
                card.joker_display_values.threshold = card.ability.extra.chips_threshold
                card.joker_display_values.is_met = scoring_chips >= card.ability.extra.chips_threshold
                card.joker_display_values.reminder_text = scoring_chips .. "/" .. card.ability.extra.chips_threshold
            end,
            style_function = function(card, text, reminder_text, extra)
                if BOF.nc(reminder_text, "children", 2) then
                    reminder_text.children[2].config.colour = card.joker_display_values.is_met and G.C.GREEN or G.C.UI.TEXT_INACTIVE
                end
            end
        }
    end
}