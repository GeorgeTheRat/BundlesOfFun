BundlesOfFun.Joker {
    key = "taillefer",
    name = "Taillefer",
    bundle = "fables",
    pos = { x = 3, y = 4 },
    soul_pos = { x = 3, y = 5 },
    attributes = { "generation", "spectral" },
    cost = 20,
    rarity = 4,
    unlocked = false,
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            local num_cards = math.min(100, G.consumeables.config.card_limit - #G.consumeables.cards)
            if num_cards > 0 then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + num_cards
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        for i = 1, num_cards do
                            SMODS.add_card {
                                set = "Spectral",
                                key_append = "bof_taillefer"
                            }
                        end
                        G.GAME.consumeable_buffer = 0
                        SMODS.calculate_effect({ message = "+" .. num_cards .. " Spectral" .. (num_cards > 1 and "s" or ""), colour = G.C.SECONDARY_SET.Spectral }, context.blueprint_card or card)
                        return true
                    end)
                }))
            end
            return nil, true
        end
    end
}