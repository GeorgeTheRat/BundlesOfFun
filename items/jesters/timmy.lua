local function amount_of_enhanced()
    local a = 0
    for k, v in pairs(G.playing_cards) do
        if next(SMODS.get_enhancements(v)) then
            a = a + 1
        end
    end
    return a
end

local function cards_above_deck()
    local a, b = (G.GAME.starting_deck_size or 52), 0
    for i = 1, #G.playing_cards do
        b = b + 1
    end

    if (a - b) < 0 then
        return -(a - b)
    end
    return 0
end

SMODS.Joker {
    key = "j_timmy",
    name = "Youngster Timmy",
    config = {
        extra = {
            mult = 1,
            chips = 4
        }
    },
    pos = { x = 5, y = 1 },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                (G.playing_cards and amount_of_enhanced() or 0) * card.ability.extra.mult,
                card.ability.extra.chips,
                (G.GAME.starting_deck_size or 52),
                (G.playing_cards and cards_above_deck() or 0) * card.ability.extra.chips,
            }   
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips * cards_above_deck(),
                mult = card.ability.extra.mult * amount_of_enhanced()
            }
        end
    end
}