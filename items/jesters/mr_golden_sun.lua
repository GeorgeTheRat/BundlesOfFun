SMODS.Joker {
    key = "j_mr_golden_sun",
    name = "Mr. Golden Sun",
    config = { extra = { xmult = 0.8 } },
    pos = { x = 3, y = 1 },
    cost = 7,
    rarity = 2,
    order = 22,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.discard and G.GAME.current_round.discards_left <= 1 and not context.blueprint then
            return {
                remove = true
            }
        end
    end
}