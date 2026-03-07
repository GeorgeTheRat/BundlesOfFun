SMODS.Joker {
    key = "j_rogue",
    name = "Rogue",
    config = { extra = { dollars = 1 } },
    pos = { x = 0, y = 2 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.end_of_round and (context.other_card:is_suit("Spades") or context.other_card:is_suit("Clubs")) then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end
}