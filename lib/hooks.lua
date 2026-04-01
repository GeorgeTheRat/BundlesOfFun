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
    draw_hand = true,
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

-- wooden deck effect
local original_back_apply_to_run = Back.apply_to_run
function Back:apply_to_run()
    original_back_apply_to_run(self)
    if self.effect.config.remove_aces then
        G.GAME.starting_params.no_aces = true
    end
    if self.effect.config.extra_cards then
        G.GAME.starting_params.extra_cards = G.GAME.starting_params.extra_cards or {}
        local extra_ranks = self.effect.config.extra_cards or { 2, 3, 4, 5 }
        local rank_key_map = { [2] = "2", [3] = "3", [4] = "4", [5] = "5" }
        for _, rank in ipairs(extra_ranks) do
            local rank_key = rank_key_map[rank]
            if rank_key then
                local standard_suits = { "H", "D", "C", "S" }
                for _, suit_key in ipairs(standard_suits) do
                    table.insert(G.GAME.starting_params.extra_cards, {
                        s = suit_key,
                        r = rank_key
                    })
                end
            end
        end
    end
end

local atpref = SMODS.add_to_pool
SMODS.add_to_pool = function (prototype_obj, args)
    if G.GAME and G.GAME.starting_params and (G.GAME.starting_params.wooden_no_aces or G.GAME.starting_params.no_aces) then
        if args and args.initial_deck and prototype_obj.key == "Ace" then
            return false
        end
    end
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
    local original_result = atpref(prototype_obj, args)
    return not (bundle and bundle_inactive) and original_result
end

-- soapy/wooden deck unlock
local original_card_remove = Card.remove
function Card:remove()
    if next(SMODS.get_enhancements(self)) ~= nil and self.edition ~= nil and self.seal ~= nil then
        G.GAME.bof_soapy_destroyed = G.GAME.bof_soapy_destroyed or {}
        G.GAME.bof_soapy_destroyed[self.config.center.key] = true
        for k, deck in pairs(G.P_CENTERS) do
            if deck.key == "l_soapy" and deck.check_for_unlock then
                deck:check_for_unlock()
                break
            end
        end
    end
    if self:get_id() == 14 then
        if not G.GAME.bof_wooden_destroyed then
            G.GAME.bof_wooden_destroyed = 0
        end
        G.GAME.bof_wooden_destroyed = G.GAME.bof_wooden_destroyed + 1
        if G.GAME.bof_wooden_destroyed >= 4 then
            for k, deck in pairs(G.P_CENTERS) do
                if deck.key == "b_bof_l_wooden" and deck.check_for_unlock then
                    local unlocked = deck:check_for_unlock()
                    if unlocked then
                        G.GAME.bof_wooden_destroyed = 0
                    end
                    break
                end
            end
        end
    end
    return original_card_remove(self)
end

local original_end_round = end_round
function end_round()
    G.GAME.bof_wooden_destroyed = 0
    return original_end_round()
end