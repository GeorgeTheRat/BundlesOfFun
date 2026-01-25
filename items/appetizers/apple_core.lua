SMODS.Joker {
    key = "a_apple_core",
    name = "Apple Core",
    config = {
        extra = {
            count = 20,
            mult = 8
        }
    },
    pos = { x = 3, y = 0 },
    cost = 1,
    rarity = 1,
    blueprint_compat = true,
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
        if context.individual and context.cardarea == G.play and card.ability.extra.count > 0 then
            card.ability.extra.count = card.ability.extra.count - 1
            return {
                mult = card.ability.extra.mult,
                message_card = context.other_card,
                func = function ()
                    if card.ability.extra.count <= 0 then
                        SMODS.calculate_effect({message = localize("k_eaten_ex")}, card)
                        SMODS.destroy_cards(card, true, true, true)
                    end
                end
            }
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