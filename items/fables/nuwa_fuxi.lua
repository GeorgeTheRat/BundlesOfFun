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
        if G.GAME and G.GAME.bof_nuwa_fuxi_trigger then
            if G.GAME.bof_nuwa_fuxi_trigger.tarot then
                G.GAME.bof_nuwa_fuxi_trigger.tarot = nil
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit + 1 then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
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
                        colour = G.C.SECONDARY_SET.Tarot
                    }
                end
            end
            if G.GAME.bof_nuwa_fuxi_trigger.spectral then
                G.GAME.bof_nuwa_fuxi_trigger.spectral = nil
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit + 1 then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        func = function()
                            play_sound("timpani")
                            SMODS.add_card({
                                set = "Spectral",
                                edition = "e_negative",
                                key_append = "bof_nuwa_fuxi"
                            })
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    return {
                        message = localize("k_plus_spectral"),
                        colour = G.C.SECONDARY_SET.Spectral
                    }
                end
            end
        end
    end
}