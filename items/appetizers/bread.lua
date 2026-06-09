SMODS.Joker {
    key = "a_bread",
    name = "Wonderous Bread",
    config = {
        extra = {
            balance = 100,
            balance_mod = 20
        }
    },
    pos = { x = 9, y = 0 },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    atlas = "joker",
    attributes = { "balance", "scaling", "food" },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.balance,
                card.ability.extra.balance_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.balance > 0 then
                return {
                    bof_balance_percent = card.ability.extra.balance * 0.01
                }
            end
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
            if card.ability.extra.balance - card.ability.extra.balance_mod > 0 then
                card.ability.extra.balance = card.ability.extra.balance - card.ability.extra.balance_mod
                return {
                    message = "-" .. card.ability.extra.balance_mod .. "%",
                    colour = G.C.PLASMA
                }
            else
                SMODS.destroy_cards(card, nil, true, true)
                return {
                    message = localize("k_eaten_ex")
                }
            end
        end
    end,
    in_pool = function(self, args)
        if G.GAME then
            if G.GAME.selected_back.effect.center.key ~= "b_plasma" then
                return true
            end
        end
        return false
    end
}