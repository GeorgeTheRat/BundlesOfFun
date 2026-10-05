BundlesOfFun.Joker {
    key = "clock",
    name = "Alarm Clock",
    bundle = "normalities",
    config = {
        extra = { 
            xmult = 1.75,
            active_display = nil
        }
    },
    pos = { x = 4, y = 5 },
    pixel_size = { h = 87 },
    attributes = { "xmult", "hands" },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local is_active = (G.GAME.bof_total_hands_played or 0) % 2 == 1
        return {
            key = is_active and "j_bof_clock_active" or "j_bof_clock_inactive",
            vars = {
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if not context.blueprint then
                G.GAME.bof_total_hands_played = (G.GAME.bof_total_hands_played or 0) + 1
                if G.GAME.bof_total_hands_played % 2 == 0 then
                    card.ability.extra.active_display = localize("k_inactive_el")
                    if not BundlesOfFun.config.custom_sounds then
                        return {
                            xmult = card.ability.extra.xmult
                        }
                    else
                        return {
                            xmult = card.ability.extra.xmult,
                            xmult_message = {
                                message = localize({
                                    type = "variable",
                                    key = "a_xmult",
                                    vars = {
                                        card.ability.extra.xmult
                                    }
                                }),
                                colour = G.C.MULT,
                                sound = "bof_alarm_ring",
                            },
                        }
                    end
                else
                    card.ability.extra.active_display = localize("k_active_ex")
                    local eval = function()
                        return G.GAME.bof_total_hands_played % 2 == 1
                    end
                    juice_card_until(card, eval, true)
                    return {
                        message = localize("k_alarm_ex"),
                        sound = BundlesOfFun.config.custom_sounds and "bof_alarm_wind" or nil
                    }
                end
            else
                G.GAME.bof_blueprint_total_hands_played = (G.GAME.bof_total_hands_played or 0) + 1
                if G.GAME.bof_blueprint_total_hands_played % 2 == 0 then
                    card.ability.extra.active_display = localize("k_inactive_el")
                    return {
                        xmult = card.ability.extra.xmult
                    }
                end
            end
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    border_nodes = {
                        {
                            ref_table = "card.joker_display_values",
                            ref_value = "xmult",
                            signed = "X",
                            retrigger_type = "^"
                        }
                    }
                }
            },
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "status_text" },
                { text = ")" }
            },
            calc_function = function(card)
                local is_active = (G.GAME.bof_total_hands_played or 0) % 2 == 1
                card.joker_display_values.xmult = is_active and card.ability.extra.xmult or 1
                card.joker_display_values.status_text = is_active and localize("k_active_ex") or localize("k_inactive_el")
                card.joker_display_values.is_active = is_active
            end,
            style_function = function(card, text, reminder_text, extra)
                if BOF.nc(reminder_text, "children", 2) then
                    reminder_text.children[2].config.colour = card.joker_display_values.is_active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
                end
            end
        }
    end
}