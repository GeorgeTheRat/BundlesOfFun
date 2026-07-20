BundlesOfFun.Consumable {
    key = "blob_l",
    name = "Blobfish Large",
    bundle = "fish",
    set = "Fish",
    pools = { ["fish_l"] = true },
    pos = { x = 6, y = 2 },
    config = {
        card_limit = 1
    },
    cost = 20,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.card_limit } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card {
                        set = "Spectral",
                        key_append = "bof_blob_l"
                    }
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
}