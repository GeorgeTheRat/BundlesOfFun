local getchip = Card.get_chip_bonus
function Card:get_chip_bonus()
	local flags = {}
	local suppress
	SMODS.calculate_context({ bof_chips_check = true, other_card = self }, flags)
	for i, v in ipairs(flags or {}) do
		for kk, vv in pairs(v or {}) do
			suppress = suppress or (vv or {}).suppress
		end
	end
	if suppress then
		return 0
	else
		return getchip(self)
	end
end

local can_sell_card_old = G.FUNCS.can_sell_card
G.FUNCS.can_sell_card = function(e)
	local card = e.config.ref_table
	if card.config.center.key == "j_bof_j_tumor_tom" and card:can_sell_card() then
        if G.jokers and (#G.jokers.cards >= (G.jokers.config.card_limit-1)) then
            e.config.colour = G.C.GREEN
            e.config.button = "sell_card"   
        else
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        end
	else
		can_sell_card_old(e)
	end
end

local skip_blind_old = G.FUNCS.skip_blind
G.FUNCS.skip_blind = function(e)
    SMODS.calculate_context({bof_pre_skip = true})
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.3,
        func = function()
            skip_blind_old(e)
            return true
        end
    }))
end