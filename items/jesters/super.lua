bof_check_super_jokers = function()
    local cards = SMODS.find_card("j_bof_j_super")
    for _, v in ipairs(cards) do
        if v and v.ability and v.ability.extra and v.ability.extra.active then
            return true
        end
    end
    return false
end

SMODS.Joker {
    key = "j_super",
    name = "Super Joker",
    config = {
        extra = {
            hands = 2,
            active = true
        },
    },
    pos = { x = 7, y = 1 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
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
                SMODS.calculate_effect(
                    { message = localize { type = "variable", key = "a_hands", vars = { card.ability.extra.hands } } }, context.blueprint_card or card)
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