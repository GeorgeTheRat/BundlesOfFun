BundlesOfFun.Joker {
    key = "apple",
    name = "Apple",
    bundle = "appetizers",
    config = {
        extra = {
            perma_mult = 3,
            perma_mult_mod = 1
        }
    },
    pos = { x = 2, y = 0 },
    attributes = { "mult", "scaling", "modify_card", "perma_bonus", "food" },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.perma_mult,
                card.ability.extra.perma_mult_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.perma_mult
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT
            }
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
            local mult_before = card.ability.extra.perma_mult
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "perma_mult",
                scalar_value = "perma_mult_mod",
                operation = "-",
                no_message = true
            })
            local return_message = nil
            if mult_before > card.ability.extra.perma_mult_mod then
                return_message = "-" .. card.ability.extra.perma_mult_mod .. " Mult"
            end
            if card.ability.extra.perma_mult <= 0 then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        play_sound("tarot1")
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        card:flip()
                        play_sound("card1", 1)
                        card:juice_up(0.3, 0.3)
                        return true
                    end
                }))
                delay(0.2)
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        card:set_ability("j_bof_core")
                        return true
                    end
                }))
                card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_eaten_ex") })
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        card:flip()
                        play_sound("tarot2", 1, 0.6)
                        card:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            return {
                message = return_message
            }
        end
    end
}