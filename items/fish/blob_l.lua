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
        if context.joker_main then
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card {
                            set = "Spectral",
                            key_append = "bof_blob_l"
                        }
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
}