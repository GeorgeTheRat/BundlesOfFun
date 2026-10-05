BundlesOfFun.Joker {
    key = "jack_frost",
    name = "Jack Frost",
    bundle = "jesters",
    config = {
        extra = {
            xmult_mod = 0.75,
            requirement = 273,
            current = 0,
            xmult = 1,
            total = 0
        }
    },
    pos = { x = 12, y = 1 },
    attributes = { "mult", "hands"},
    cost = 8,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_mod,
                card.ability.extra.requirement,
                card.ability.extra.current,
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            local total = 0
            for k, v in pairs(context.scoring_hand) do
                total = total + v.base.nominal + v.ability.bonus + (v.ability.perma_bonus or 0)
            end
            card.ability.extra.total = total
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "current",
                scalar_value = "total",
                no_message = true
            })
            if card.ability.extra.current >= card.ability.extra.requirement then
                for i = 1, math.floor(card.ability.extra.current / card.ability.extra.requirement) do
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "xmult",
                        scalar_value = "xmult_mod",
                        no_message = true
                    })
                    card.ability.extra.current = card.ability.extra.current - card.ability.extra.requirement
                end
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.MULT
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    border_nodes = {
                        {
                            ref_table = "card.ability.extra",
                            ref_value = "xmult",
                            signed = "X",
                            retrigger_type = "^"
                        }
                    }
                }
            },
            reminder_text = {
                { text = "[" },
                { ref_table = "card.joker_display_values", ref_value = "display_current" },
                { text = "/" },
                { ref_table = "card.ability.extra", ref_value = "requirement" },
                { text = "]" }
            },
            calc_function = function(card)
                if G.STATE == G.STATES.SELECTING_HAND then
                    local scoring_chips = 0
                    local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                    if text ~= "Unknown" then
                        for _, scoring_card in pairs(scoring_hand) do
                            scoring_chips = scoring_chips + scoring_card.base.nominal + scoring_card.ability.bonus + (scoring_card.ability.perma_bonus or 0)
                        end
                    end
                    card.joker_display_values.display_current = card.ability.extra.current + scoring_chips
                else
                    card.joker_display_values.display_current = card.ability.extra.current
                end
                card.joker_display_values.is_met = card.joker_display_values.display_current >= card.ability.extra.requirement
            end,
            style_function = function(card, text, reminder_text, extra)
                if BOF.nc(reminder_text, "children") then
                    for i = 2, 4 do
                        if reminder_text.children[i] then
                            reminder_text.children[i].config.colour = card.joker_display_values.is_met and G.C.GREEN or G.C.UI.TEXT_INACTIVE
                        end
                    end
                end
            end
        }
    end
}