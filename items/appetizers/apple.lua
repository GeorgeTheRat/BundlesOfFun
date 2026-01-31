SMODS.Joker {
    key = "a_apple",
    name = "Apple",
    config = {
        extra = {
            mult = 4,
            mult_mod = 1
        }
    },
    pos = { x = 2, y = 0 },
    cost = 1,
    rarity = 1,
    order = 8,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.mult_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.mult
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT
            }
        end
        if context.end_of_round and context.main_eval then
            card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.mult_mod
            local return_message = nil
            if card.ability.extra.mult - card.ability.extra.mult_mod > 0 then -- rudimentary way of making sure two messages don't happen at once
                return_message = "-" .. card.ability.extra.mult_mod .. "Mult"
            end
            return {
                message = return_message,
                colour = G.C.MULT,
                func = function ()
                    if card.ability.extra.mult <= 0 then
                        SMODS.calculate_effect({message = localize("k_eaten_ex")}, card)
                        card:set_ability("j_bof_a_apple_core")
                    end
                end
            }
        end
    end
}