SMODS.Joker {
    key = "j_barber",
    name = "Barber",
    pos = { x = 1, y = 2 },
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.4,
                        func = function()
                            if G.deck and G.deck.cards and #G.deck.cards > 0 then
                                local random_index = pseudorandom(pseudoseed("bof_j_barber"))
                                local card_to_destroy = G.deck.cards[math.floor(random_index * #G.deck.cards) + 1]
                                card_to_destroy:start_dissolve()
                                card:juice_up(0.3, 0.5)
                                G.E_MANAGER:add_event(Event({
                                    trigger = "after",
                                    delay = 0.3,
                                    func = function()
                                        card_to_destroy:remove()
                                        return true
                                    end
                                }))
                            end
                            return true
                        end
                    }))
                    return true
                end
            }))
        end
    end
}