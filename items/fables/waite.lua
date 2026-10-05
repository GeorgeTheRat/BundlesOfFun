BundlesOfFun.Joker {
    key = "waite",
    name = "Waite",
    bundle = "fables",
    config = {
        extra = {
            xmult_mod = 1.5,
            xmult = 1
        }
    },
    pos = { x = 2, y = 6 },
    soul_pos = { x = 2, y = 7 },
    attributes = { "xmult", "scaling", "reset" },
    cost = 20,
    rarity = 4,
    unlocked = false,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_mod,
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmult_mod",
                message_colour = G.C.MULT
            })
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
            SMODS.reset_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                reset_value = 1,
            })
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    border_nodes = {
                        {
                            ref_table = "card.ability.extra",
                            ref_value = "xmult",
                            signed = "X",
                            retrigger_type = "^"
                        }
                    }
                }
            }
        }
    end
}