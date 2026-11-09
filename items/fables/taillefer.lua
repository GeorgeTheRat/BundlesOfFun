BundlesOfFun.Joker {
    key = "taillefer",
    name = "Taillefer",
    bundle = "fables",
    config = { extra = { consumable_slots = 1 } },
    pos = { x = 3, y = 6 },
    soul_pos = { x = 3, y = 7 },
    attributes = { "generation", "spectral" },
    cost = 20,
    rarity = 4,
    unlocked = false,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.consumable_slots } }
    end,
    add_to_deck = function(self, card)
        G.consumeables:change_size(card.ability.extra.consumable_slots)
    end,
    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            local num_cards = math.min(100, G.consumeables.config.card_limit - #G.consumeables.cards)
            if num_cards > 0 then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + num_cards
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for i = 1, num_cards do
                            SMODS.add_card {
                                set = "Spectral",
                                key_append = "bof_taillefer"
                            }
                        end
                        G.GAME.consumeable_buffer = 0
                        -- on the third day of christmas, my true love gave to me
                        local three_french_hens = context.blueprint_card or card
                        -- two_turtle_doves
                        -- and a_partridge_in_a_pear_tree
                        SMODS.calculate_effect({
                            message = localize({
                                type = "variable",
                                key = (num_cards == 1 and "a_bof_spectral" or "a_bof_spectrals"),
                                vars = { num_cards }
                            }),
                            colour = G.C.SECONDARY_SET.Spectral
                        }, three_french_hens)
                        return true
                    end
                }))
            end
        end
    end,
    remove_from_deck = function(self, card)
        G.consumeables:change_size(-card.ability.extra.consumable_slots)
    end,
    joker_display_def = function(JokerDisplay)
    end
}