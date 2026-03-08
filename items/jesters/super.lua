BoF_check_super_jokers = function()
    for k, v in pairs(next(SMODS.find_card("j_bof_j_super_joker"))) do
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
            hand_give = 2,
            active = true
        },
    },
    pos = { x = 7, y = 1 },
    cost = 7,
    rarity = 2,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hand_give,
                card.ability.extra.active
            }
        }
    end,
    calculate = function(self, card, context)
        if context.bof_emergency and not context.blueprint then
            if card.ability.extra.active then
                ease_hands_played(card.ability.extra.hand_give)
                card.ability.extra.active = false
                return {
                    message = "+" .. card.ability.extra.hand_give .. " " .. localize("k_hud_hands")
                }
            else
                G.STATE = G.STATES.NEW_ROUND
            end
        end
        if context.end_of_round and not context.blueprint and not card.ability.extra.active then
            card.ability.extra.active = true
            return {
                message = localize("bof_ready")
            }
        end
    end
}