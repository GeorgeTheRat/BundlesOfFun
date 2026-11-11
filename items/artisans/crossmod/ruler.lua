BundlesOfFun.Joker {
    key = "ruler",
    name = "Ruler",
    bundle = "artisans",
    crossmod = "paperback",
    config = {
        extra = {
            amount = 5,
            prob_bonus = 0.1,
            xchips = 0.05
        }
    },
    pos = { x = 1, y = 0 },
    attributes = { "perma_bonus", "suit", "dark", "mod_chance" },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    atlas = "crossmod",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.amount,
                card.ability.extra.prob_bonus,
                card.ability.extra.xchips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            local crowns = 0
            for _, played_card in ipairs(context.full_hand) do
                if played_card:is_suit("paperback_Crowns") then
                    crowns = crowns + 1
                end
            end
            if crowns >= card.ability.extra.amount then
                local suits = {}
                for _, hand_card in ipairs(G.hand.cards) do
                    if BOF.nc(hand_card.base, "suit") and not hand_card.no_suit then
                        suits[hand_card.base.suit] = true
                    end
                end
                local unique_suits = 0
                for _ in pairs(suits) do
                    unique_suits = unique_suits + 1
                end
                local juice = false
                for _, played_card in ipairs(context.full_hand) do
                    if played_card:is_suit("paperback_Crowns") then
                        played_card.ability.perma_paperback_plus_odds = (played_card.ability.perma_paperback_plus_odds or 0) + unique_suits * card.ability.extra.prob_bonus
                        played_card:juice_up()
                        juice = true
                    end
                end
                if juice then
                    return {
                        message = localize("k_upgrade_ex"),
                        colour = G.C.GREEN
                    }
                end
            end
        end
    end
}
