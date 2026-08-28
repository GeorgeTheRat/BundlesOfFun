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
    pos = { x = 7, y = 9 },
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
                if faces then
                    local last_mult = card.ability.extra.mult
                    card.ability.extra.mult = 0
                    if last_mult > 0 then
                        return {
                            message = localize("k_reset")
                        }
                    end
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
                if faces then
                    local last_mult = card.ability.extra.mult
                    card.ability.extra.mult = 0
                    if last_mult > 0 then
                        return {
                            message = localize("k_reset")
                        }
                    end
                end
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}