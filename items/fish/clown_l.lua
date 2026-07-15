BundlesOfFun.Consumable {
    key = "clown_l",
    name = "Clownfish Legendary",
    bundle = "fish",
    set = "Fish",
    pools = { ["fish_l"] = true },
    pos = { x = 4, y = 2 },
    config = { card_limit = 1 },
    cost = 20,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.card_limit } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local rarity = 1
            while rarity == 1 or rarity == 4 do
                rarity = SMODS.poll_rarity("Joker", "clown_l")
            end
            if type(rarity) == "number" and rarity > 1 and rarity < 4 then
                local rarity_names = { [2] = "Uncommon", [3] = "Rare" }
                rarity = rarity_names[rarity]
            end
            if #G.jokers.cards < G.jokers.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card {
                            set = "Joker",
                            rarity = rarity,
                            key_append = "bof_clown_l"
                        }
                        return true
                    end
                }))
                return {
                    message = localize("k_plus_joker"),
                    colour = G.C.RARITY[rarity] or G.C.WHITE
                }
            end
        end
    end
}