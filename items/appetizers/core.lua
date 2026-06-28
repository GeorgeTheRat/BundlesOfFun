BundlesOfFun.Joker {
    key = "core",
    name = "Apple Core",
    bundle = "appetizers",
    config = {
        extra = {
            count = 20,
            mult = 8
        }
    },
    pos = { x = 3, y = 0 },
    attributes = { "mult", "scaling", "passive", "food" },
    cost = 1,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    atlas = "joker",
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.count,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if card.ability.extra.count <= 0 and not context.blueprint then
                SMODS.destroy_cards(card, { pinch_anim = true })
                return {
                    message = localize("k_eaten_ex")
                }
            else
                card.ability.extra.count = card.ability.extra.count - 1
                return {
                    mult = card.ability.extra.mult,
                    message_card = context.other_card,
                }
            end
        end
        if context.bof_chips_check and card.ability.extra.count > 0 then
            return {
                suppress = true
            }
        end
    end,
    in_pool = function(self, args)
        return false
    end
}