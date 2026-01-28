SMODS.Joker {
    key = "j_evil_eddrick",
    name = "Evil Eddrick",
    config = {
        extra = {
            chips = 40,
            mult = 10
        }
    },
    pos = { x = 4, y = 2 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_left == 0 then
            return {
                chips = card.ability.extra.chips,
                extra = {
                    mult = card.ability.extra.mult
                }
            }
        end
    end
}