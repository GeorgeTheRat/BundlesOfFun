BundlesOfFun.Joker {
    key = "grapes",
    name = "Grapes",
    bundle = "appetizers",
    config = {
        extra = {
            chips = 100,
            mult = 25,
            xmult = 3
        }
    },
    pos = { x = 2, y = 0 },
    attributes = { "mult", "chips", "xmult", "boss_blind", "food" },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                xmult = card.ability.extra.xmult
            }
        end
        if context.beat_boss and context.main_eval and not context.blueprint then
            SMODS.destroy_cards(card, { pinch_anim = true })
            return {
                message = localize("k_eaten_ex")
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+", colour = G.C.CHIPS },
                { ref_table = "card.ability.extra", ref_value = "chips", colour = G.C.CHIPS },
                { text = " +", colour = G.C.MULT },
                { ref_table = "card.ability.extra", ref_value = "mult", colour = G.C.MULT },
                { text = " " }, -- for spacing
                {
                    border_nodes = {
                        { text = "X" },
                        { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "xmult" }
                    }
                }
            },
        }
    end
}