SMODS.Joker {
    key = "f_dagonet",
    name = "Dagonet",
    config = {
        extra = {
            mult = 0,
            mult_mod = 5
        }
    },
    pos = { x = 4, y = 4 },
    soul_pos = { x = 4, y = 5 },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.mult_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.discard and not context.other_card.debuff and SMODS.has_enhancement(context.other_card, "m_stone") and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "mult_mod",
                message_colour = G.C.MULT
            })
        end
        if context.individual and not context.other_card.debuff and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_stone") then
            return {
                mult = card.ability.extra.mult,
                card = context.other_card
            }
        end
    end
}