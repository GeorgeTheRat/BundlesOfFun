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
    calculate = function(self, card, context)
        if G.jokers.cards[1] == card then
            if context.setting_blind then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        if G.consumeables.config.card_limit - #G.consumeables.cards >= 1 then
                            play_sound("timpani")
                            card:juice_up(0.3, 0.5)
                            SMODS.add_card({
                                set = "Tarot",
                                key_append = "f_nuwa_fuxi"
                            })
                        end
                        return true
                    end
                }))
            end
            if context.blind_defeated then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        if G.consumeables.config.card_limit - #G.consumeables.cards >= 0 then
                            play_sound("timpani")
                            card:juice_up(0.3, 0.5)
                            SMODS.add_card({
                                set = "Tarot",
                                edition = "e_negative",
                                key_append = "f_nuwa_fuxi"
                            })
                        end
                        return true
                    end
                }))
            end
        end
        if G.jokers.cards[#G.jokers.cards] == card then
            if context.setting_blind then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        if G.consumeables.config.card_limit - #G.consumeables.cards >= 0 then
                            play_sound("timpani")
                            card:juice_up(0.3, 0.5)
                            SMODS.add_card({
                                set = "fish_s",
                                area = G.consumeables,
                                key_append = "f_nuwa_fuxi"
                            })
                        end
                        return true
                    end
                }))
            end
            if context.blind_defeated then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        if G.consumeables.config.card_limit - #G.consumeables.cards >= 0 then
                            play_sound("timpani")
                            card:juice_up(0.3, 0.5)
                            SMODS.add_card({
                                set = "fish_b",
                                area = G.consumeables,
                                key_append = "f_nuwa_fuxi"
                            })
                        end
                        return true
                    end
                }))
            end
        end
    end
}