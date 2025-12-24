SMODS.Joker {
    key = "a_blueberry",
    name = "Blueberry",
    config = {
        extra = {
            perma_bonus = 6,
            perma_bonus_mod = 1
        }
    },
    pos = { x = 0, y = 0 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
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
                message = "Upgrade!",
                colour = G.C.CHIPS,
                card = context.other_card
            }
        end
        if context.end_of_round and not context.game_over and context.main_eval and not context.blueprint then
            if card.ability.perma_bonus - card.ability.extra.perma_bonus_mod <= 0 then
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
            else
                card.ability.perma_bonus = card.ability.perma_bonus - card.ability.extra.perma_bonus_mod
                return {
                    message = "-" .. card.ability.extra.perma_bonus_mod .. " Chip" .. (card.ability.extra.perma_bonus_mod > 1 and "s" or ""),
                    colour = G.C.CHIPS
                }
            end
        end
    end
}