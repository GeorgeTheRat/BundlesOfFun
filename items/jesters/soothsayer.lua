BundlesOfFun.Joker {
    key = "soothsayer",
    name = "Soothsayer",
    bundle = "jesters",
    pos = { x = 5, y = 3 },
    attributes = { "generation", "planet", "seals" },
    config = { extra = { hand = nil } },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_SEALS["Blue"])
    end,
    calculate = function(self, card, context)
        if context.pre_discard then
            card.ability.extra.hand = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
        end
        if context.discard and context.other_card.seal and context.other_card.seal == "Blue" and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    local _planet = nil
                    for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
                        if planet_center.config.hand_type == card.ability.extra.hand then
                            _planet = planet_center.key
                        end
                    end
                    if _planet then
                        SMODS.add_card({ key = _planet })
                    end
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            return {
                message = localize("k_plus_planet"),
                colour = G.C.SECONDARY_SET.Planet,
                card = context.other_card
            }
        end
    end,
    in_pool = function(self, args)
        if not G.deck then
            return false
        end
        for k, v in pairs(G.deck.cards) do
            if v.seal and v.seal == "Blue" then
                return true
            end
        end
        return false
    end
}