BundlesOfFun.Joker {
    key = "beekeeper",
    name = "Beekeeper",
    bundle = "artisans",
    config = {
        extra = {
            amount = 5,
            odds = 3,
            dollars = 1
        }
    },
    pos = { x = 14, y = 4 },
    attributes = { "money", "perma_bonus", "suit", "diamonds", "chance" },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "bof_beekeeper")
        return {
            vars = {
                card.ability.extra.amount,
                numerator,
                denominator,
                card.ability.extra.dollars,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.initial_scoring_step then
            local diamonds = 0
            for _, played_card in ipairs(context.full_hand) do
                if played_card:is_suit("Diamonds") then
                    diamonds = diamonds + 1
                end
            end
            if diamonds >= card.ability.extra.amount then
                local suits = {}
                for _, hand_card in ipairs(G.hand.cards) do
                    if hand_card.base and hand_card.base.suit then
                        suits[hand_card.base.suit] = true
                    end
                end
                local unique_suits = 0
                for _ in pairs(suits) do
                    unique_suits = unique_suits + 1
                end
                local juice = false
                for _, played_card in ipairs(context.full_hand) do
                    if SMODS.pseudorandom_probability(card, "bof_beekeeper", 1, card.ability.extra.odds) then
                        played_card.ability.perma_dollars = (played_card.ability.perma_dollars or 0) + unique_suits * card.ability.extra.dollars
                        played_card:juice_up()
                        juice = true
                    end
                end
                if juice then
                    return {
                        message = localize("k_upgrade_ex"),
                        colour = G.C.MONEY
                    }
                end
            end
        end
    end
}