bof_check_super_jokers = function()
    local cards = SMODS.find_card("j_bof_super")
    for _, v in ipairs(cards) do
        if BOF.nc(v, "ability", "extra", "active") then
            return true
        end
    end
    return false
end

BundlesOfFun.Joker {
    key = "super",
    name = "Super Joker",
    bundle = "jesters",
    config = {
        extra = {
            hands = 1,
            active = true
        },
    },
    pos = { x = 7, y = 2 },
    attributes = { "hands" },
    cost = 7,
    rarity = 2,
    blueprint_compat = true, -- i fear this was a mistake
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hands,
                card.ability.extra.active
            }
        }
    end,
    calculate = function(self, card, context)
        if context.bof_emergency then
            if card.ability.extra.active then
                ease_hands_played(card.ability.extra.hands)
                if not context.blueprint then
                    card.ability.extra.active = false
                end
                -- on the fifth day of christmas, my true love gave to me
                local six_geese_a_laying = context.blueprint_card or card
                -- five_gold_rings
                -- four_calling_birds
                -- three_french_hens
                -- two_turtle_doves
                -- and a_partridge_in_a_pear_tree
                SMODS.calculate_effect({ message = localize{ type = "variable", key = (card.ability.extra.hands == 1 and "a_bof_hand" or "a_hands"), vars = { card.ability.extra.hands } } }, six_geese_a_laying)
            else
                G.STATE = G.STATES.NEW_ROUND
            end
        end
        if context.end_of_round and not context.blueprint and not card.ability.extra.active then
            card.ability.extra.active = true
            return {
                message = localize("k_ready_ex")
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+", colour = G.C.BLUE },
                { ref_table = "card.joker_display_values", ref_value = "hands", colour = G.C.BLUE }
            },
            calc_function = function(card)
                local playing_hand = next(G.play.cards)
                local hands_left = G.GAME.current_round and G.GAME.current_round.hands_left
                local active = playing_hand and hands_left == 0 or not playing_hand and hands_left == 1 and card.ability.extra.active
                card.joker_display_values.hands = active and card.ability.extra.hands or 0
            end
        }
    end
}