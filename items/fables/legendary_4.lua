SMODS.Joker {
    key = "f_taillefer",
    name = "Taillefer",
    pos = { x = 0, y = 0 },
    cost = 20,
    rarity = 4,
    -- order = 0,
    blueprint_compat = true,
    atlas = "placeholder",
    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            for i = 1, G.consumeables.config.card_limit - #G.consumeables.cards do
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.add_card {
                                    set = "Spectral",
                                    key_append = "bof_f_taillefer"
                                }
                                G.GAME.consumeable_buffer = 0
                                return true
                            end
                        }))
                        SMODS.calculate_effect({ message = localize("k_plus_spectral"), colour = G.C.SECONDARY_SET.Spectral }, context.blueprint_card or card)
                        return true
                    end)
                }))
            end
            return nil, true
        end
    end
}