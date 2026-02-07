SMODS.Joker {
    key = "a_durian",
    name = "Durian",
    pos = { x = 6, y = 0 },
    cost = 1,
    rarity = 2,
    order = 5,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_fool
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            for i = 1, G.consumeables.config.card_limit - #G.consumeables.cards do
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.add_card {
                                    key = "c_fool",
                                    key_append = "bof_a_durian"
                                }
                                G.GAME.consumeable_buffer = 0
                                return true
                            end
                        }))
                        SMODS.calculate_effect({ message = localize("k_plus_tarot"), colour = G.C.SECONDARY_SET.Tarot }, context.blueprint_card or card)
                        return true
                    end)
                }))
            end
            return nil, true
        end
    end
}