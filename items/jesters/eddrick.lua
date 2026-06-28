BundlesOfFun.Joker {
    key = "eddrick",
    name = "Evil Eddrick",
    bundle = "jesters",
    config = {
        extra = {
            chips = 50,
            mult = 10
        }
    },
    pos = { x = 8, y = 1 },
    attributes = { "mult", "chips", "hands" },
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