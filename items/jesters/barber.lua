SMODS.Joker {
    key = "j_barber",
    name = "Barber",
    config = {
        extra = {
            cards = 1,
            mult_mod = 3,
            mult = 0,
        }
    },
    pos = { x = 1, y = 2 },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.cards,
                card.ability.extra.mult_mod,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local trigger = false
            if G.deck and G.deck.cards and #G.deck.cards > 0 then
                for i = 1, #G.deck.cards do
                    if next(SMODS.get_enhancements(G.deck.cards[i])) then
                        trigger = true
                        break
                    end
                end
            end
            if trigger then
                for i = 1, card.ability.extra.cards do
                    local card = context.blueprint_card or card
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.4,
                        func = function()
                            play_sound("tarot1")
                            card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.4,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                trigger = "after",
                                delay = 0.15,
                                func = function()
                                    if G.deck and G.deck.cards and #G.deck.cards > 0 then
                                        for i = 1, #G.deck.cards do
                                            if next(SMODS.get_enhancements(G.deck.cards[i])) then
                                                G.deck.cards[i]:set_ability("c_base", nil, true)
                                                break
                                            end
                                        end
                                    end
                                    return true
                                end
                            }))
                            G.E_MANAGER:add_event(Event({
                                trigger = "after",
                                delay = 0.1,
                                func = function()
                                    play_sound("tarot2", 1, 0.6)
                                    return true
                                end
                            }))
                            return true
                        end
                    }))
                end
            end
            if not context.blueprint then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "mult_mod"
                })
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end

}