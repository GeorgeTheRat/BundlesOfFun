BoF_check_super_jokers = function()
    local a = 0
    for k, v in pairs(SMODS.find_card("j_bof_j_super_joker")) do
        if v and v.ability and v.ability.extra and v.ability.extra.active then
            a = a + 1
        end
    end
    if a > 0 then
        return true
    end
    return false
end

SMODS.Joker {
    key = "j_super_joker",
    name = "Super Joker",
    config = {
        extra = {
            hand_give = 2,
            active = true
        },
    },
    pos = { x = 7, y = 1 },
    rarity = 2,
    order = 18,
    blueprint_compat = false,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
                cae.hand_give,
                cae.active
            }
        }
    end,
    calculate = function(self,card,context)
        local cae = card.ability.extra
        if context.bof_emergency and not context.blueprint then
            if cae.active then
                ease_hands_played(cae.hand_give)
                cae.active = false
                return{
                    message = "+" .. cae.hand_give .. " " .. localize("k_hud_hands")
                }
            else
                G.STATE = G.STATES.NEW_ROUND
            end
        end
        if context.end_of_round and not context.blueprint and not cae.active then
            cae.active = true
            return{
                message = localize("bof_ready")
            }
        end
    end
}