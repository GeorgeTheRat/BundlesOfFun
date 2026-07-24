BundlesOfFun.Joker {
    key = "keyboard",
    name = "Keyboard",
    bundle = "normalities",
    config = { extra = { mult = 8 } },
    -- pos = { x = 0, y = 0 },
    attributes = { "mult", "rank", "eight" },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        local eight_tally = 0
        if G.deck and G.deck.cards then
            for _, playing_card in ipairs(G.deck.cards) do
                if playing_card:get_id() == 8 then eight_tally = eight_tally + 1 end
            end
        end
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.mult * eight_tally
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 8 then
                local eight_tally = 0
                if G.deck and G.deck.cards then
                    for _, playing_card in ipairs(G.deck.cards) do
                        if playing_card:get_id() == 8 then eight_tally = eight_tally + 1 end
                    end
                end
                if eight_tally > 0 then
                    return {
                        mult = card.ability.extra.mult * eight_tally
                    }
                end
            end
        end
    end
}