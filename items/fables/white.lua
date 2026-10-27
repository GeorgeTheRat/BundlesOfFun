BundlesOfFun.Joker {
    key = "white",
    name = "White",
    bundle = "fables",
    -- pos = { x = 12, y = 6 },
    -- soul_pos = { x = 12, y = 7 },
    config = {
        extra = {
            hands = 1,
            bonus_hands = 2
        }
    },
    attributes = { "hands", "legendary" },
    cost = 20,
    rarity = 4,
    unlocked = false,
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hands,
                card.ability.extra.bonus_hands
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and BOF.nc(G.GAME.hands[context.scoring_name], "played_this_round") <= 1 then
            local hand_index = 0
            for i, h in ipairs(G.handlist) do
                if h == context.scoring_name then
                    hand_index = i
                    break
                end
            end
            local is_straight_or_higher = hand_index <= 8
            local hands_to_add = is_straight_or_higher and card.ability.extra.bonus_hands or card.ability.extra.hands
            if hands_to_add > 0 then
                ease_hands_played(hands_to_add)
                return {
                    message = localize({ type = "variable", key = hands_to_add == 1 and "a_bof_hand" or "a_hands", vars = { hands_to_add } }),
                    colour = G.C.BLUE
                }
            end
        end
    end
}