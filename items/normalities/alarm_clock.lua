SMODS.Joker {
    key = "n_alarm_clock",
    name = "Alarm Clock",
    config = { extra = { 
        xmult = 2,
        active = false,
        active_display = nil
    } },
    pos = { x = 9, y = 3 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        if not cae.active_display then
            cae.active_display = localize("bof_inactive") 
        end
        return { vars = { cae.xmult, cae.active_display } }
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.joker_main then
            if cae.active then
               cae. active_display = localize("bof_inactive")
                cae.active= false
                return{
                    xmult = cae.xmult,
                    -- xmult_message = localize("k_bof_ring")
                }
            elseif not cae.active and not context.blueprint then
                cae. active_display = localize("bof_active")
                cae.active = true
                card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_bof_alarm") })
                		local eval = function()
                            return card.ability.extra.active == true
                        end
                        juice_card_until(card, eval, true)
            end
        end
    end
}