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
        if context.before then
            local clubs = 0
            for _, played_card in ipairs(context.full_hand) do
                if played_card:is_suit("Clubs") then
                    clubs = clubs + 1
                end
            end
            if clubs >= card.ability.extra.amount then
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