BundlesOfFun.Joker {
    key = "melon",
    name = "Royal Melon",
    bundle = "appetizers",
    config = {
        extra = {
            count = 25,
            sell_cost_mod = 3
        }
    },
    pos = { x = 1, y = 1 },
    attributes = { "face", "economy", "scaling", "sell_value", "food" },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.count,
                card.ability.extra.sell_cost_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for _, played_card in ipairs(context.full_hand) do
                if played_card:is_face() then
                    if card.ability.extra.count - 1 <= 0 then
                        SMODS.destroy_cards(card, { pinch_anim = true })
                        return {
                            message = localize("k_eaten_ex")
                        }
                    else
                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "count",
                            operation = "-",
                            scalar_table = { 1 },
                            scalar_value = 1,
                            no_message = true
                        })
                    end
                end 
            end
            return {
                message = card.ability.extra.count .. ""
            }
        end
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            card.sell_cost = card.sell_cost + card.ability.extra.sell_cost_mod
            return {
                func = function()
                    card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_val_up"), colour = G.C.GOLD })
                end
            }
        end
    end
}