BoF_amount_of_enhanced = function()
    local a = 0
    for k, v in pairs(G.playing_cards) do
        if v.ability.set == "Enhanced" then
            a = a + 1
        end
    end
    return a
end

BoF_cards_above_deck = function()
    local a,b = (G.GAME.starting_deck_size or 52) ,0
    for i = 1, #G.playing_cards do
        b = b + 1
    end

    if (a - b) < 0 then
        return -(a - b)
    end
    return 0
end

SMODS.Joker {
    key = "j_youngster_timmy",
    name = "Youngster Timmy",
    config = {
        extra = {
            mult = 1,
            chips = 4
        },
    },
    pos = { x = 0, y = 0 },
    cost = 4,
    rarity = 2,
    order = 20,
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
                (G.playing_cards and BoF_amount_of_enhanced() or 0)*cae.mult,
                (G.playing_cards and BoF_cards_above_deck() or 0)*cae.chips,
                (G.GAME.starting_deck_size or 52),
                cae.mult,
                cae.chips
            }
        }
    end,
    calculate = function(self,card,context)
        local cae = card.ability.extra
        if context.joker_main then
            return{
                chips = cae.chips * BoF_cards_above_deck(),
                mult = cae.mult * BoF_amount_of_enhanced()
            }
        end
    end
}