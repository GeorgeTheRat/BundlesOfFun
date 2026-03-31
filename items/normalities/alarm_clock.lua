SMODS.Joker {
    key = "n_alarm_clock",
    name = "Alarm Clock",
    config = {
        extra = { 
            xmult = 1.75,
            active = false,
            active_display = nil
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
                return {
                    message = localize("k_bof_ring"),
                    colour = G.C.RED,
                    xmult = card.ability.extra.xmult,
                    sound = "multhit2",
                    remove_default_message = true
                }
            elseif not card.ability.extra.active and not context.blueprint then
                card.ability.extra.active_display = localize("bof_active")
                card.ability.extra.active = true
                local eval = function()
                    return card.ability.extra.active == true and not G.RESET_JIGGLES
                end
                juice_card_until(card, eval, true)
                return { -- pretty sure this has to be a return otherwise the little jiggle don't work
                    message = localize("k_bof_alarm")
                }
            end
        end
    end
}