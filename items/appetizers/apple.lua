 SMODS.Joker {
     key = "a_apple",
     name = "Apple",
     config = {
         extra = {
            mult = 4,
            drop = 1
         }
     },
     pos = { x = 2, y = 0 },
     cost = 1,
     rarity = 1,
     blueprint_compat = true,
     atlas = "joker",
     loc_vars = function(self, info_queue, card)
         return {
             vars = {
                card.ability.extra.mult,
                card.ability.extra.drop
             }
         }
     end,
     calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            SMODS.scale_card(card, {
                ref_table = context.other_card,
                ref_value = "perma_mult",
                scalar_table = card.ability.extra,
                scalar_value = "mult"
            })
        end

        if context.end_of_round and context.main_eval then
            SMODS.scale_card(card,{
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "drop",
                operation = "-"
            })

            if card.ability.extra.mult <= 0 then
                SMODS.calculate_effect({message = localize("k_eaten_ex")}, card)
                card:set_ability("j_bof_a_apple_core") --Do we want instant core, or Cavendish logic?
            end
        end
     end
 }