SMODS.Joker {
    key = "j_laggard_larry",
    name = "Laggard Larry",
    config = { extra = { dollars = 3 } },
    pos = { x = 2, y = 3 },
    cost = 5,
    rarity = 1,
    order = 30,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.before and (G.GAME.current_round.hands_played == 0 or G.GAME.current_round.hands_played == G.GAME.round_resets.hands - 1) then
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end
}