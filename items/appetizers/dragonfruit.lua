SMODS.Joker {
    key = "a_dragonfruit",
    name = "Dragonfruit",
    config = {
        extra = {
            chips = 100,
            mult = 25,
            xmult = 2.5
        }
    },
    pos = { x = 5, y = 0 },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
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
                extra = {
                    mult = card.ability.extra.mult,
                    extra = {
                        xmult = card.ability.extra.xmult
                    }
                }
            }
        end
        if context.end_of_round and not context.game_over and context.main_eval and context.beat_boss and not context.blueprint then
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
                message = localize("k_eaten"),
                colour = G.C.FILTER,
            }
        end
    end
}