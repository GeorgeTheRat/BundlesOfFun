BundlesOfFun.Joker {
    key = "farmer",
    name = "Farmer",
    bundle = "artisans",
    config = {
        extra = {
            amount = 5,
            mult = 1
        }
    },
    pos = { x = 13, y = 4 },
    attributes = { "mult", "perma_bonus", "suit", "clubs" },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.amount,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.initial_scoring_step then
            local clubs = 0
            for _, played_card in ipairs(context.full_hand) do
                if played_card:is_suit("Clubs") then
                    clubs = clubs + 1
                end
            end
            if clubs >= card.ability.extra.amount then
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
                    played_card.ability.perma_mult = (played_card.ability.perma_mult or 0) + unique_suits * card.ability.extra.mult
                    played_card:juice_up()
                    juice = true
                end
                if juice then
                    return {
                        message = localize("k_upgrade_ex"),
                        colour = G.C.MULT
                    }
                end
            end
        end
    end
}