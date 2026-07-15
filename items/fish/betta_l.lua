BundlesOfFun.Consumable {
    key = "betta_l",
    name = "Betta Legendary",
    bundle = "fish",
    set = "Fish",
    soul_set = "Fish",
    pools = { ["fish_l"] = true },
    pos = { x = 1, y = 2 },
    config = {
        card_limit = 1,
        extra = { consumable_slots = 0 }
    },
    cost = 20,
    unlocked = false,
    hidden = true,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.card_limit } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local total_mult = 0
            if G.GAME and G.GAME.hands then
                for hand_name, hand_data in pairs(G.GAME.hands) do
                    if hand_data.visible and hand_data.mult then
                        total_mult = total_mult + hand_data.mult
                    end
                end
            end
            return {
                mult = total_mult
            }
        end
    end
}