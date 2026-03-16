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
        if G.jokers and (#G.jokers.cards >= (G.jokers.config.card_limit - 1)) then
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

SMODS.Booster:take_ownership_by_kind("Arcana", {
        create_card = function(self, card, i)
            local _card
            if next(SMODS.find_card("j_bof_j_eureka")) and pseudorandom("j_bof_j_eureka") > 0.8 then
                local consumeables = {}
                for _, c in pairs(G.P_CENTER_POOLS.Consumeables) do
                    if c.set ~= "Tarot" then
                        table.insert(consumeables, c)
                    end
                end
                _card = {
                    set = pseudorandom_element(consumeables, pseudoseed("j_bof_j_eureka")).set,
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = false,
                    key_append = "ar3"
                }
            elseif G.GAME.used_vouchers.v_omen_globe and pseudorandom("omen_globe") > 0.8 then
                _card = {
                    set = "Spectral",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append = "ar2"
                }
			else
                _card = {
                    set = "Tarot",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append = "ar1"
                }
            end
            return _card
        end
}, true)

SMODS.Booster:take_ownership_by_kind("Celestial", {
    create_card = function(self, card, i)
        local _card
        if next(SMODS.find_card("j_bof_j_eureka")) and pseudorandom("j_bof_j_eureka") > 0.8 then
            _card = {
                set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "pl2"
            }
        elseif G.GAME.used_vouchers.v_telescope and i == 1 then
            local _planet, _hand, _tally = nil, nil, 0
            for _, handname in ipairs(G.handlist) do
                if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > _tally then
                    _hand = handname
                    _tally = G.GAME.hands[handname].played
                end
            end
            if _hand then
                for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
                    if planet_center.config.hand_type == _hand then
                        _planet = planet_center.key
                    end
                end
            end
            _card = {
                set = "Planet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key = _planet,
                key_append = "pl1"
            }
        else
            _card = {
                set = "Planet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "pl1"
            }
        end
        return _card
    end
}, true)

SMODS.Booster:take_ownership_by_kind("Spectral", {
    create_card = function(self, card, i)
		local _card
		if next(SMODS.find_card("j_bof_j_eureka")) and pseudorandom("j_bof_j_eureka") > 0.8 then
            _card = {
                set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "spe1"
            }
		else
			_card = {
				set = "Spectral",
				area = G.pack_cards,
				skip_materialize = true,
				soulable = true,
				key_append = "spe"
			}
		end
		return _card
    end
}, true)

local atpref = SMODS.add_to_pool
SMODS.add_to_pool = function (prototype_obj, args)
    local bundle, bundle_inactive, prefix
    local item_key = prototype_obj.key
    local category_map = {
        a = "appetizers",
        f = "fables",
        j = "jesters",
        n = "normalities"
    }
    if item_key:sub(1,6) == "j_bof_" then
        prefix = item_key:sub(7, 7)
        bundle = category_map[prefix]
        bundle_inactive = not (G.GAME.bof_bundles and G.GAME.bof_bundles[bundle or "AAAAA"])
    end

    return not (bundle and bundle_inactive) and atpref(prototype_obj, args)
end