BundlesOfFun.Joker {
    key = "mezzetino",
    name = "Mezzetino",
    bundle = "fables",
    pos = { x = 8, y = 7 },
    soul_pos = { x = 8, y = 8 },
    attributes = { "generation", "planet" },
    cost = 20,
    rarity = 4,
    unlocked = false,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit + 1 then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = "before",
                delay = 0.4,
                func = function()
                    if G.GAME.last_hand_played then
                        local _planet = nil
                        for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
                            if planet_center.config.hand_type == G.GAME.last_hand_played then
                                _planet = planet_center.key
                            end
                        end
                        if _planet then
                            SMODS.add_card({
                                key = _planet,
                                edition = "e_negative"
                            })
                        end
                        G.GAME.consumeable_buffer = 0
                    end
                    return true
                end
            }))
            return {
                message = localize("k_plus_planet"),
                colour = G.C.SECONDARY_SET.Planet
            }
        end
    end
}