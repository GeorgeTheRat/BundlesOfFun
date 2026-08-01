bof_check_super_jokers = function()
    local cards = SMODS.find_card("j_bof_super")
    for _, v in ipairs(cards) do
        if v and v.ability and v.ability.extra and v.ability.extra.active then
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
            if card.ability and card.ability.extra and card.ability.extra.active then
                ease_hands_played(card.ability.extra.hands)
                if not context.blueprint then
                    card.ability.extra.active = false
                end
                -- on the fifth day of christmas, my true love gave to me
                local five_gold_rings = context.blueprint_card or card
                -- four_calling_birds
                -- three_french_hens
                -- two_turtle_doves
                -- and a_partridge_in_a_pear_tree
                SMODS.calculate_effect({ message = localize { type = "variable", key = "a_hands", vars = { card.ability.extra.hands } } }, five_gold_rings)
            else
                G.STATE = G.STATES.NEW_ROUND
            end
        end
        if context.end_of_round and not context.blueprint and not card.ability.extra.active then
            card.ability.extra.active = true
            return {
                message = localize("k_bof_ready")
            }
        end
    end
}