SMODS.Joker {
    key = "j_furious_joker",
    name = "Furious Joker",
    config = {
        extra = {
            dollars = 8
        }
    },
    pos = { x = 4, y = 3 },
    cost = 5,
    rarity = 1,
    order = 29,
    blueprint_compat = false,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
                cae.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
    end,
    add_to_deck = function(self,card,from_debuff)
        G.GAME.modifiers.no_interest = true
    end,
    remove_from_deck = function(self,card,from_debuff)
        G.GAME.modifiers.no_interest = false
    end,
    calc_dollar_bonus = function(self,card)
        local cae = card.ability.extra
        return cae.dollars
    end
}