BundlesOfFun.Joker {
    key = "koshary",
    name = "Koshary",
    bundle = "appetizers",
    config = {
        extra = {
            xmult = 3,
            xmult_mod = 1,
            enhanced_req = 3,
        }
    },
    -- pos = { x = 14, y = 0 },
    attributes = { "xmult", "enhancements", "food" },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.xmult_mod,
                card.ability.extra.enhanced_req
            }
        }
    end,
    calculate = function(self, card, context)
        if context.after then
            local enhanced_count = 0
            for _, played_card in ipairs(context.full_hand) do
                local enhancements = SMODS.get_enhancements(played_card)
                if next(enhancements) then
                    enhanced_count = enhanced_count + 1
                end
            end
            if enhanced_count < card.ability.extra.enhanced_req then
                if card.ability.extra.xmult <= card.ability.extra.xmult_mod + 1 then
                    SMODS.destroy_cards(card, { pinch_anim = true })
                    return {
                        message = localize("k_eaten_ex")
                    }
                else
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "xmult",
                        scalar_value = "xmult_mod",
                        operation = "-",
                        message_key = "a_xmult_minus",
                        message_colour = G.C.MULT
                    })
                end
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}
