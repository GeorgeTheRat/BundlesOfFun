BundlesOfFun.Joker {
    key = "jouster",
    name = "Jouster",
    bundle = "jesters",
    config = { extra = { xmult = 2 } },
    pos = { x = 1, y = 4 },
    attributes = { "xmult" },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local blind_chips = G.GAME.blind.chips
            local scoring = hand_chips * mult
            local boosted_scoring = hand_chips * mult * card.ability.extra.xmult
            if scoring < blind_chips and boosted_scoring >= blind_chips then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}