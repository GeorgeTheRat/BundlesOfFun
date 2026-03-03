SMODS.Joker {
    key = "j_jack_frost",
    name = "Jack Frost",
    config = {
        extra = {
            mult = 27.3
        },
    },
    pos = { x = 2, y = 1 },
    cost = 4,
    rarity = 3,
    order = 23,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
                cae.mult,
                0
            }   
        }
    end,
    calculate = function(self,card,context)
        local cae = card.ability.extra
        if context.joker_main then
            if G.GAME.hands[context.scoring_name].played_this_round<=1 then
                return{
                    mult = cae.mult
                }
            else
                return{
                    mult = 0
                }
            end
        end
    end
}