BundlesOfFun.Joker {
    key = "wizard",
    name = "Wizard",
    bundle = "artisans",
    crossmod = "paperback",
    config = {
        extra = {
            amount = 5,
            odds = 5,
            xchips = 0.05
        }
    },
    pos = { x = 0, y = 0 },
    attributes = { "xchips", "perma_bonus", "suit", "chance" },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    atlas = "crossmod",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "bof_wizard")
        return {
            vars = {
                card.ability.extra.amount,
                numerator,
                denominator,
                card.ability.extra.xchips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            local stars = 0
            for _, played_card in ipairs(context.full_hand) do
                if played_card:is_suit("paperback_Stars") then
                    stars = stars + 1
                end
            end
            if stars >= card.ability.extra.amount then
                local regular_suits = {}
                local wild_count = 0
                for _, hand_card in ipairs(G.hand.cards) do
                    if BOF.nc(hand_card.base, "suit") and not hand_card.no_suit then
                        if BOF.nc(BOF.nc(hand_card, "config", "center"), "any_suit") then
                            wild_count = wild_count + 1
                        else
                            regular_suits[hand_card.base.suit] = true
                        end
                    end
                end
                local unique_regular_suits = 0
                for _ in pairs(regular_suits) do
                    unique_regular_suits = unique_regular_suits + 1
                end
                local total_suits = 0
                for _ in pairs(SMODS.Suits) do
                    total_suits = total_suits + 1
                end
                local unique_suits, juice = math.min(unique_regular_suits + wild_count, total_suits)
                for _, played_card in ipairs(context.full_hand) do
                    if SMODS.pseudorandom_probability(card, "bof_wizard", 1, card.ability.extra.odds) then
                        played_card.ability.perma_x_chips = (played_card.ability.perma_x_chips or 0) + unique_suits * card.ability.extra.xchips
                        played_card:juice_up()
                        juice = true
                    end
                end
                if juice then
                    return {
                        message = localize("k_upgrade_ex"),
                        colour = G.CHIPS
                    }
                end
            end
        end
    end
}
