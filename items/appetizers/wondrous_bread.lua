SMODS.Joker {
    key = "wondrous_bread",
    name = "Wondrous Bread",
    config = {
        extra = {
            balance = 100,
            balance_mod = 20
        }
    },
    pos = { x = 4, y = 1 },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.balance,
                card.ability.extra.balance_mod,
                colours = {
                    { 0.8, 0.45, 0.85, 1 }
                }
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
        if context.end_of_round and not context.game_over and context.main_eval and not context.blueprint then
            if card.ability.extra.balance - card.ability.extra.balance_mod > 0 then
                card.ability.extra.balance = card.ability.extra.balance - card.ability.extra.balance_mod
                return {
                    message = "-" .. card.ability.extra.balance_mod .. "%",
                    colour = { 0.8, 0.45, 0.85, 1 }
                }
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("tarot1")
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true
                            end,
                        }))
                        return true
                    end,
                }))
                return {
                    message = "Eaten!",
                    colour = G.C.FILTER,
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