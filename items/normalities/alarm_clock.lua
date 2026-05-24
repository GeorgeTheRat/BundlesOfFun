SMODS.Joker {
    key = "n_alarm_clock",
    name = "Alarm Clock",
    config = {
        extra = { 
            xmult = 1.75,
            active = false,
            active_display = nil,
            juicing = false
        }
    },
    pos = { x = 9, y = 3 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        if not card.ability.extra.active_display then
            card.ability.extra.active_display = localize("bof_inactive") 
        end
        return { 
            vars = {
                card.ability.extra.xmult, 
                card.ability.extra.active_display 
            } 
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.active then
                card.ability.extra.active_display = localize("bof_inactive")
                card.ability.extra.active = false
                card.ability.extra.juicing = false
                return {
                    xmult = card.ability.extra.xmult,
                    message = "X" .. card.ability.extra.xmult .. " Mult",
                    colour = G.C.MULT,
                    sound = "bof_alarm_ring",
                    remove_default_message = true
                }
            elseif not card.ability.extra.active and not context.blueprint then
                card.ability.extra.active_display = localize("bof_active")
                card.ability.extra.active = true
                card.ability.extra.juicing = true
                local eval = function()
                    return card.ability.extra.juicing == true
                end
                juice_card_until(card, eval, true)
                return {
                    message = localize("k_bof_alarm"),
                    sound = "bof_alarm_wind"
                }
            end
        end
    end
}