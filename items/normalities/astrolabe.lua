BundlesOfFun.Joker {
    key = "astrolabe",
    name = "Astrolabe",
    bundle = "normalities",
    pos = { x = 8, y = 6 },
    pixel_size = { h = 82 },
    attributes = { "passive", "planet", "space" },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    atlas = "joker",
    calculate = function(self, card, context)
        if
            context.using_consumeable and
            context.consumeable.ability and
            context.consumeable.ability.set == "Planet" and
            context.area == G.pack_cards and
            SMODS.OPENED_BOOSTER and
            SMODS.OPENED_BOOSTER.config.center.kind == "Celestial"
        then
            if G.consumeables.config.card_limit > #G.consumeables.cards + G.GAME.consumeable_buffer then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("timpani")
                        SMODS.add_card({ set = "Planet" })
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                return {
                    message = localize("k_plus_planet"),
                    colour = G.C.SECONDARY_SET.Planet
                }
            end
        end
    end
}