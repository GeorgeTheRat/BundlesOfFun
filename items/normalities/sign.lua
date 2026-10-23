BundlesOfFun.Joker {
    key = "sign",
    name = "Road Sign",
    bundle = "normalities",
    config = { extra = { xmult = 4 } },
    -- pos = { x = 13, y = 5 },
    attributes = { "xmult", "hand_type" },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.after then
            card.ability.extra.previous_hand = G.GAME.last_hand_played
        end
        if context.joker_main and card.ability.extra.previous_hand == "Straight" then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}