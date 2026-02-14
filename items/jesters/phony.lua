SMODS.Joker {
    key = "j_phony",
    name = "Phony",
    config = {
        extra = {
            mult = 5,
            chips = 10
        },
    },
    pos = { x = 0, y = 0 },
    cost = 3,
    rarity = 1,
    order = 31,
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
                cae.mult,
                cae.chips
            }
        }
    end,
    calculate = function(self,card,context)
        local cae = card.ability.extra
        if context.joker_main then
            return{
                mult = cae.mult,
                chips = -cae.chips
            }
        end
    end
}