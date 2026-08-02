BundlesOfFun.Joker {
    key = "prom_king",
    name = "Prom King",
    bundle = "jesters",
    config = { extra = { xmult = 0.25 } },
    pos = { x = 2, y = 5 },
    attributes = { "xmult", "king" },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 13 then
            local queen_count = 0
            for _, played_card in ipairs(context.full_hand) do
                if played_card:get_id() == 12 then
                    queen_count = queen_count + 1
                end
            end
            if G.hand and G.hand.cards then
                for _, hand_card in ipairs(G.hand.cards) do
                    if hand_card:get_id() == 12 then
                        queen_count = queen_count + 1
                    end
                end
            end
            if queen_count > 0 then
                return {
                    xmult = (card.ability.extra.xmult * queen_count) + 1
                }
            end
        end
    end
}