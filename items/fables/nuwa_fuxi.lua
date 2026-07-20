BundlesOfFun.Joker {
    key = "nuwa_fuxi",
    name = "Nüwa & Fuxi",
    bundle = { "fables", { "fish" } },
    pos = { x = 6, y = 4 },
    soul_pos = { x = 6, y = 5 },
    attributes = { "generation", "tarot", "fish" },
    cost = 20,
    rarity = 4,
    unlocked = false,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
    end,
    calculate = function(self, card, context)
        if G.jokers.cards[1] == card then
            if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        play_sound("timpani")
                        SMODS.add_card({
                            set = "Tarot",
                            key_append = "bof_nuwa_fuxi"
                        })
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                return {
                    message = localize("k_plus_tarot"),
                    colour = G.C.SET.Tarot
                }
            end
            if context.blind_defeated and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit + 1 then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        play_sound("timpani")
                        SMODS.add_card({
                            set = "Tarot",
                            edition = "e_negative",
                            key_append = "bof_nuwa_fuxi"
                        })
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                return {
                    message = localize("k_plus_tarot"),
                    colour = G.C.SET.Tarot
                }
            end
        end
        if G.jokers.cards[#G.jokers.cards] == card then
            if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit + (G.GAME.bof_fish_extra_consumable_slots or 0) + 1 then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        play_sound("timpani")
                        SMODS.add_card({
                            set = "fish_s",
                            area = G.consumeables,
                            key_append = "bof_nuwa_fuxi"
                        })
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                return {
                    message = localize("k_plus_fish"),
                    colour = G.C.SET.Fish
                }
            end
            if context.blind_defeated and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit + (G.GAME.bof_fish_extra_consumable_slots or 0) + 1 then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        play_sound("timpani")
                        SMODS.add_card({
                            set = "fish_b",
                            area = G.consumeables,
                            key_append = "bof_nuwa_fuxi"
                        })
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                return {
                    message = localize("k_plus_fish"),
                    colour = G.C.SET.Fish
                }
            end
        end
    end
}