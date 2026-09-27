BundlesOfFun.Joker {
    key = "bartender",
    name = "Bartender",
    bundle = "artisans",
    config = {
        extra = {
            amount = 5,
            chips = 7
        }
    },
    pos = { x = 12, y = 4 },
    attributes = { "chips", "perma_bonus", "suit", "spades" },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.amount,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.initial_scoring_step then
            local spades = 0
            for _, played_card in ipairs(context.full_hand) do
                if played_card:is_suit("Spades") then
                    spades = spades + 1
                end
            end
            if spades >= card.ability.extra.amount then
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
                    played_card.ability.perma_bonus = (played_card.ability.perma_bonus or 0) + unique_suits * card.ability.extra.chips
                    played_card:juice_up()
                    juice = true
                end
                if juice then
                    return {
                        message = localize("k_upgrade_ex"),
                        colour = G.C.BLUE
                    }
                end
            end
        end
    end
}