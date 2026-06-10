SMODS.Joker {
    key = "n_clock",
    name = "Alarm Clock",
    config = {
        extra = { 
            xmult = 1.75,
            active_display = nil
        }
    },
    pos = { x = 9, y = 3 },
    pixel_size = { h = 87 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local is_active = (G.GAME.bof_total_hands_played or 0) % 2 == 1
        return {
            key = is_active and "j_bof_n_clock_active" or "j_bof_n_clock_inactive",
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
                    card.ability.extra.active_display = localize("k_bof_inactive")
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
                    card.ability.extra.active_display = localize("k_bof_active")
                    local eval = function()
                        return G.GAME.bof_total_hands_played % 2 == 1
                    end
                    juice_card_until(card, eval, true)
                    return {
                        message = localize("k_bof_alarm"),
                        sound = BundlesOfFun.config.custom_sounds and "bof_alarm_wind" or nil
                    }
                end
            else
                G.GAME.bof_blueprint_total_hands_played = (G.GAME.bof_total_hands_played or 0) + 1
                if G.GAME.bof_blueprint_total_hands_played % 2 == 0 then
                    card.ability.extra.active_display = localize("k_bof_inactive")
                    return {
                        xmult = card.ability.extra.xmult
                    }
                end
            end
        end
    end
}