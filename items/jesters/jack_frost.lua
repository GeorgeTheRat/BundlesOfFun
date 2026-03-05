SMODS.Joker {
    key = "j_jack_frost",
    name = "Jack Frost",
    config = { extra = { mult = 27.3 } },
    pos = { x = 2, y = 1 },
    cost = 8,
    rarity = 2,
    order = 23,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            if G.GAME.hands[context.scoring_name].played_this_round <= 1 then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}