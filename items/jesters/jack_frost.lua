BundlesOfFun.Joker {
    key = "jack_frost",
    name = "Jack Frost",
    bundle = "jesters",
    config = {
        extra = {
            xmult_mod = 0.75,
            requirement = 273,
            current = 0,
            xmult = 1,
            total = 0
        }
    },
    pos = { x = 2, y = 3 },
    attributes = { "mult", "hands"},
    cost = 8,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_mod,
                card.ability.extra.requirement,
                card.ability.extra.current,
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            local total = 0
            for k, v in pairs(context.scoring_hand) do
                total = total + v.base.nominal + v.ability.bonus + (v.ability.perma_bonus or 0)
            end
            card.ability.extra.total = total
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "current",
                scalar_value = "total",
                no_message = true
            })
            if card.ability.extra.current >= card.ability.extra.requirement then
                for i = 1, math.floor(card.ability.extra.current / card.ability.extra.requirement) do
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "xmult",
                        scalar_value = "xmult_mod",
                        no_message = true
                    })
                    card.ability.extra.current = card.ability.extra.current - card.ability.extra.requirement
                end
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.MULT
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    border_nodes = {
                        { text = "X" },
                        { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "xmult" }
                    }
                }
            },
            reminder_text = {
                { text = "[" },
                { ref_table = "card.ability.extra", ref_value = "current" },
                { text = "/" },
                { ref_table = "card.ability.extra", ref_value = "requirement" },
                { text = "]" }
            }
        }
    end
}