BundlesOfFun.Joker {
    key = "ticket",
    name = "Parking Ticket",
    bundle = "normalities",
    config = {
        extra = {
            mult_mod = 1,
            mult = 0
        }
    },
    pos = { x = 7, y = 5 },
    attributes = { "chips", "scaling", "passive" },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    perishable_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_mod,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if not context.blueprint then
            if context.before then
                local faces = false
                for _, playing_card in pairs(G.hand.cards) do
                    if playing_card:is_face() then
                        faces = true
                        break
                    end
                end
                if faces and card.ability.extra.mult ~= 0 then
                    SMODS.reset_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "mult",
                        reset_value = 0,
                    })
                else
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "mult",
                        scalar_value = "mult_mod",
                        message_colour = G.C.MULT
                    })
                end
            end
            if context.pre_discard then
                local faces = false
                for _, playing_card in pairs(context.full_hand) do
                    if playing_card:is_face() then
                        faces = true
                        break
                    end
                end
                if faces and card.ability.extra.mult ~= 0 then
                    SMODS.reset_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "mult",
                        reset_value = 0,
                    })
                end
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    ref_table = "card.ability.extra",
                    ref_value = "mult",
                    signed = true,
                    retrigger_type = "*",
                    colour = G.C.MULT
                }
            }
        }
    end
}