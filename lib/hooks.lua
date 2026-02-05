local getchip = Card.get_chip_bonus
function Card:get_chip_bonus()
    local flags = {}
    local suppress
    SMODS.calculate_context({bof_chips_check = true, other_card = self}, flags)
    for i,v in ipairs(flags or {}) do
        for kk,vv in pairs(v or {}) do
            suppress = suppress or (vv or {}).suppress
        end
    end
    if suppress then
        return 0
    else
        return getchip(self)
    end
end