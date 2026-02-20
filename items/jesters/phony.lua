SMODS.Joker {
    key = "j_phony",
    name = "Phony",
    config = {
        extra = {
            mult = 5,
            chips = 10
        },
    },
    pos = { x = 7, y = 2 },
    cost = 3,
    rarity = 1,
    order = 31,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return{
                mult = card.ability.extra.mult,
                chips = -card.ability.extra.chips
            }
        end
    end
}