SMODS.Joker {
    key = "a_durian",
    name = "Durian",
    pos = { x = 6, y = 0 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = "joker",
    attributes = { "generation", "tarot", "on_sell", "food" },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_fool
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            local num_cards = math.min(100, G.consumeables.config.card_limit - #G.consumeables.cards)
            if num_cards > 0 then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + num_cards
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        for i = 1, num_cards do
                            SMODS.add_card {
                                key = "c_fool",
                                key_append = "bof_a_durian"
                            }
                        end
                        G.GAME.consumeable_buffer = 0
                        SMODS.calculate_effect({ message = "+" .. num_cards .. " Fool" .. (num_cards > 1 and "s" or ""), colour = G.C.SECONDARY_SET.Tarot }, context.blueprint_card or card)
                        return true
                    end)
                }))
            end
            return nil, true
        end
    end
}