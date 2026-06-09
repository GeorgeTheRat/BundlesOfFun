SMODS.Consumable {
    key = "i_goldfish_l",
    name = "Goldfish Legendary",
    set = "Fish",
    pools = { ["fish_l"] = true },
    pos = { x = 5, y = 1 },
    config = { card_limit = 1 },
    cost = 20,
    hidden = true,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.card_limit } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                dollars = math.min(G.GAME.interest_cap / 5, math.floor(G.GAME.dollars / 5))
            }
        end
    end
}