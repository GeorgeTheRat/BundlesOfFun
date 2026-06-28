BundlesOfFun.Joker {
    key = "blueberry",
    name = "Blueberry",
    bundle = "appetizers",
    config = {
        extra = {
            perma_bonus = 6,
            perma_bonus_mod = 1
        }
    },
    pos = { x = 0, y = 0 },
    attributes = { "chips", "scaling", "modify_card", "perma_bonus", "food" },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.perma_bonus,
                card.ability.extra.perma_bonus_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.perma_bonus
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.CHIPS
            }
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
            if card.ability.extra.perma_bonus - card.ability.extra.perma_bonus_mod <= 0 and not context.blueprint then
                SMODS.destroy_cards(card, { pinch_anim = true })
                return {
                    message = localize("k_eaten_ex")
                }
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "perma_bonus",
                    scalar_value = "perma_bonus_mod",
                    operation = "-",
                    scaling_message = {
                        message = "-" .. card.ability.extra.perma_bonus_mod .. " Chip" .. (card.ability.extra.perma_bonus_mod > 1 and "s" or ""),
                        colour = G.C.CHIPS
                    }
                })
            end
        end
    end
}