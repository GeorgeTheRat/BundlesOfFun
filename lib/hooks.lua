-- make it so that fish cards cannot be used
local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    local abc = G_UIDEF_use_and_sell_buttons_ref(card)
    local sell = nil
    if (card.area == G.consumeables and card.ability.set == "Fish") then 
        sell = {
            n = G.UIT.C,
            config = { align = "cm" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = {
                        ref_table = card,
                        align = "cm",
                        padding = 0.1,
                        r = 0.08,
                        minw = 1.25,
                        hover = true,
                        shadow = true,
                        colour = G.C.UI.BACKGROUND_INACTIVE,
                        one_press = true,
                        button = "sell_card",
                        func = "can_sell_card",
                        handy_insta_action = "sell",
                    },
                    nodes = {
                        { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                        {
                            n = G.UIT.C,
                            config = { align = "tm" },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", maxw = 1.25 },
                                    nodes = {
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = localize("b_sell"),
                                                colour = G.C.UI.TEXT_LIGHT,
                                                scale = 0.4,
                                                shadow = true,
                                            },
                                        },
                                    },
                                },
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm" },
                                    nodes = {
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = localize("$"),
                                                colour = G.C.WHITE,
                                                scale = 0.4,
                                                shadow = true,
                                            },
                                        },
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                ref_table = card,
                                                ref_value = "sell_cost_label",
                                                colour = G.C.WHITE,
                                                scale = 0.55,
                                                shadow = true,
                                            },
                                        },
                                    },
                                },
                            },
                        },
                    },
                },
            },
        }
        return {
            n = G.UIT.ROOT,
            config = { padding = 0, colour = G.C.CLEAR },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { padding = 0.1, align = "cm" },
                    nodes = {
                        { n = G.UIT.R, config = { align = "cm" }, nodes = { sell } }
                    },
                },
            },
        }
    end
    return abc
end

-- apple core logic
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

-- eureka logic
SMODS.Booster:take_ownership_by_kind("Arcana", {
        create_card = function(self, card, i)
            local _card
            if next(SMODS.find_card("j_bof_eureka")) and pseudorandom("j_bof_eureka") > 0.8 then
                local consumeables = {}
                for _, c in pairs(G.P_CENTER_POOLS.Consumeables) do
                    if c.set ~= "Tarot" then
                        table.insert(consumeables, c)
                    end
                end
                _card = {
                    set = pseudorandom_element(consumeables, pseudoseed("j_bof_eureka")).set,
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
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
    update_pack = function(self, dt)
        local state_wasnt_complete = not G.STATE_COMPLETE
        SMODS.Booster.update_pack(self, dt)
        if next(SMODS.find_card("j_bof_eureka")) and state_wasnt_complete then
            G.E_MANAGER:add_event(Event({
                trigger = "immediate",
                func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = "immediate",
                        func = function()
                            G.FUNCS.draw_from_deck_to_hand()
                            return true
                        end
                    }))
                    return true
                end
            }))
        end
    end,
    create_card = function(self, card, i)
        local _card
        if next(SMODS.find_card("j_bof_eureka")) and pseudorandom("j_bof_eureka") > 0.8 then
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
		if next(SMODS.find_card("j_bof_eureka")) and pseudorandom("j_bof_eureka") > 0.8 then
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
    local original_result = atpref(prototype_obj, args)
    return original_result
end

-- fossilized deck: re-check unlock whenever consumable slots change
local original_consumeable_emplace = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
    local ret = original_consumeable_emplace(self, card, location, stay_flipped)
    if G.consumeables and self == G.consumeables then
        check_for_unlock({ type = "bof_consumable_held" })
    end
    return ret
end

-- wooden deck card sounds
local original_play_sound = play_sound
function play_sound(sound_code, pitch, vol, stop_previous_instance)
    if BundlesOfFun.config.custom_sounds and G.GAME and G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == "b_bof_wooden" then
        if sound_code == "card1" then
            sound_code = "bof_wooden_1"
        elseif sound_code == "paper1" then
            sound_code = "bof_wooden_2"
            vol = 0.1
        elseif sound_code == "cardSlide1" or sound_code == "cardSlide2" then
            sound_code = "bof_wooden_3"
        elseif sound_code == "cardFan2" then
            sound_code = "bof_wooden_4"
        end
    end
    return original_play_sound(sound_code, pitch, vol, stop_previous_instance)
end

-- laughing stock: reset blind stuff on new run
local original_game_start_run = Game.start_run
function Game:start_run(arg)
    if G.GAME.bof_laughing_stock_original_mult then
        for _, blind_table in pairs(G.GAME.bof_laughing_stock_original_mult) do
            for key, original_mult in pairs(blind_table) do
                if type(original_mult) ~= "number" then
                    return
                end
                if G.P_BLINDS and G.P_BLINDS[key] then
                    G.P_BLINDS[key].mult = original_mult
                elseif G.P_TEENY_BLINDS and G.P_TEENY_BLINDS[key] then
                    G.P_TEENY_BLINDS[key].mult = original_mult
                elseif G.P_CEO_BLINDS and G.P_CEO_BLINDS[key] then
                    G.P_CEO_BLINDS[key].mult = original_mult
                end
            end
        end
        G.GAME.bof_laughing_stock_original_mult = nil
    end
    G.GAME.bof_fish_extra_rounds = 0
    G.GAME.bof_fish_extra_consumable_slots = 0
    G.GAME.bof_scratch_off_shop_reroll_count = 0
    G.GAME.bof_vouchers_redeemed_this_ante = 0
    G.GAME.bof_current_ante = 1
    G.PROFILES[G.SETTINGS.profile].career_stats.bof_boosters_skipped = G.PROFILES[G.SETTINGS.profile].career_stats.bof_boosters_skipped or 0
    return original_game_start_run(self, arg)
end

-- track voucher purchases for lottery ticket unlock
local original_use_card = G.FUNCS.use_card
function G.FUNCS.use_card(e, mute, nosave)
    local card = e.config.ref_table
    local result = original_use_card(e, mute, nosave)
    if card and card.ability and card.ability.set == "Voucher" and card.area == G.shop_vouchers then
        local current_ante = G.GAME.round_resets.ante or 1
        if current_ante ~= G.GAME.bof_current_ante then
            G.GAME.bof_vouchers_redeemed_this_ante = 0
            G.GAME.bof_current_ante = current_ante
        end
        G.GAME.bof_vouchers_purchased = (G.GAME.bof_vouchers_purchased or 0) + 1
        G.GAME.bof_vouchers_redeemed_this_ante = (G.GAME.bof_vouchers_redeemed_this_ante or 0) + 1
        check_for_unlock({ bof_vouchers_redeemed_this_ante = G.GAME.bof_vouchers_redeemed_this_ante })
    end
    return result
end

-- track booster skips for shoplifting unlock
local original_skip_booster = G.FUNCS.skip_booster
function G.FUNCS.skip_booster(e)
    inc_career_stat("bof_boosters_skipped", 1)
    return original_skip_booster(e)
end

-- retro deck logic
local original_skip_blind = G.FUNCS.skip_blind
G.FUNCS.skip_blind = function(e)
    original_skip_blind(e)
    local back = G.GAME and G.GAME.selected_back
    if back and back.effect and back.effect.center and back.effect.center.key == "b_bof_retro" then
        local amount = (back.effect.center.config and back.effect.center.config.extra and back.effect.center.config.extra.hands) or 4
        G.E_MANAGER:add_event(Event({
            trigger = "immediate",
            func = function()
                local pool = {}
                for hand_name, hand_data in pairs(G.GAME.hands) do
                    if hand_data.visible then pool[#pool + 1] = hand_name end
                end
                local picks = math.min(amount, #pool)
                for _ = 1, picks do
                    local idx = pseudorandom(pseudoseed("b_bof_retro"), 1, #pool)
                    local hand = table.remove(pool, idx)
                    level_up_hand(G.deck.cards[1] or G.deck, hand, nil, 1)
                end
                return true
            end
        }))
    end
end

-- hotboxer: rightmost shop slot is always tarot
-- pianoman: force common jokers in shop and booster packs
local create_card_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if next(SMODS.find_card("j_bof_hotboxer")) and G.shop_jokers and G.shop_jokers.cards and area == G.shop_jokers and _type ~= "Tarot" then
        if (#G.shop_jokers.cards + 1) == G.GAME.shop.joker_max then
            return create_card_ref("Tarot", area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
        end
    end
    if
        G.GAME.bof_pianoman_common_only and
        (area == G.shop_jokers or area == G.pack_cards) and
        (forced_key and G.P_CENTERS[forced_key] and G.P_CENTERS[forced_key].set == "Joker")
    then
        _type = "Joker"
        legendary = nil
        _rarity = 0.7
        forced_key = nil
    end
    return create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
end

-- continuation of hotboxer
-- ice bucket and buried treasure logic
local function bof_apply_fish_voucher_state(card)
    if not card or not card.ability or card.ability.set ~= "Fish" or type(card.ability.extra) ~= "table" then
        return
    end
    local extra_rounds = (G.GAME and G.GAME.bof_fish_extra_rounds) or 0
    local extra_slots = (G.GAME and G.GAME.bof_fish_extra_consumable_slots) or 0
    local applied_rounds = card.ability.bof_fish_extra_rounds_applied or 0
    local applied_slots = card.ability.bof_fish_extra_slots_applied or 0
    local round_delta = extra_rounds - applied_rounds
    local slot_delta = extra_slots - applied_slots
    if round_delta ~= 0 and card.ability.extra.rounds_remaining then
        card.ability.extra.rounds_remaining = card.ability.extra.rounds_remaining + round_delta
    end
    if slot_delta ~= 0 then
        card.ability.card_limit = (card.ability.card_limit or 0) + slot_delta
        card.ability.extra.consumable_slots = (card.ability.extra.consumable_slots or 0) + slot_delta
    end
    card.ability.bof_fish_extra_rounds_applied = extra_rounds
    card.ability.bof_fish_extra_slots_applied = extra_slots
end
BundlesOfFun.apply_fish_voucher_state = bof_apply_fish_voucher_state
local original_card_set_ability = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    original_card_set_ability(self, center, initial, delay_sprites)
    bof_apply_fish_voucher_state(self)
end
local original_smods_create_card = SMODS.create_card
function SMODS.create_card(t)
    if next(SMODS.find_card("j_bof_hotboxer")) and G.shop_jokers and G.shop_jokers.cards and t.area == G.shop_jokers and t.set ~= "Tarot" then
        if (#G.shop_jokers.cards + 1) == G.GAME.shop.joker_max then
            t.set = "Tarot"
            t.key = nil
        end
    end
    if
        G.GAME.bof_pianoman_common_only and
        t and
        t.area and
        (t.area == G.shop_jokers or t.area == G.pack_cards) and
        (t.set == "Joker" or (t.key and G.P_CENTERS[t.key] and G.P_CENTERS[t.key].set == "Joker"))
    then
        t.set = "Joker"
        t.legendary = nil
        t.rarity = 0.7
        t.key = nil
    end
    local card = original_smods_create_card(t)
    bof_apply_fish_voucher_state(card)
    return card
end
local original_card_add_to_deck = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    local was_added = not self.added_to_deck
    original_card_add_to_deck(self, from_debuff)
    if was_added and self.added_to_deck and self.area == G.consumeables and self.ability and type(self.ability.extra) == "table" and self.ability.extra.consumable_slots then
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + self.ability.extra.consumable_slots
    end
end
local original_card_remove_from_deck = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    local extra_slots = self.ability and type(self.ability.extra) == "table" and tonumber(self.ability.extra.consumable_slots) or 0
    original_card_remove_from_deck(self, from_debuff)
    if self.area == G.consumeables and extra_slots > 0 and G.consumeables then
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - extra_slots
    end
end

-- eraser: prevent seal from triggering when marked for removal
local old_calculate_seal = Card.calculate_seal
function Card:calculate_seal(context, ...)
    if self.ability.bof_delay_seal_removal then
        return nil
    end
    return old_calculate_seal(self, context, ...)
end

-- director condition logic
local oldsmodscalculaterepetitions = SMODS.calculate_repetitions
SMODS.calculate_repetitions = function(card, context, reps)
    card.bof_retriggered = nil
    local g = oldsmodscalculaterepetitions(card, context, reps)
    if #(g or reps) >= 2 then
        card.bof_retriggered = true
    end
    return g
end

-- illegal wares: triple negative edition weight
local negative_weight_ref = G.P_CENTERS.e_negative.get_weight
SMODS.Edition:take_ownership("e_negative", {
    get_weight = function(self, weight, object_type)
        local base_weight = negative_weight_ref and negative_weight_ref(self, weight, object_type) or self.weight
        if G.GAME.used_vouchers["v_bof_illegal_wares"] then
            return base_weight * 3
        end
        return base_weight
    end
}, true)

-- make it so that perkeo can't copy legendary fish
local legendary_fish_keys = {
    "c_bof_bass_l",
    "c_bof_betta_l",
    "c_bof_goldfish_l",
    "c_bof_trout_l"
}
SMODS.Joker:take_ownership("perkeo", {
    name = "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
        local main_end = {}
        if G.consumeables and G.consumeables.cards then
            for _, consumable in ipairs(G.consumeables.cards) do
                if consumable.config.center and consumable.config.center.key then
                    for _, legendary_key in ipairs(legendary_fish_keys) do
                        if consumable.config.center.key == legendary_key then
                            localize { type = "other", key = "k_bof_perkeo_legendary", nodes = main_end }
                            break
                        end
                    end
                    if main_end then break end
                end
            end
        end
        return { vars = { card.ability.extra }, main_end = main_end[1] }
    end,
    calculate = function(self, card, context)
        if context.ending_shop then
            local eligibleConsumables = {}
            for k, v in pairs(G.consumeables.cards) do
                if v.ability.consumeable and not SMODS.in_scoring(v.config.center.key, legendary_fish_keys) then
                    table.insert(eligibleConsumables, v)
                end
            end
            if #eligibleConsumables > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local card = copy_card(pseudorandom_element(eligibleConsumables, pseudoseed("perkeo")), nil)
                        card:set_edition({ negative = true }, true)
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        return true
                    end}))
                -- on the seventh day of christmas, my true love gave to me
                local seven_swans_a_swimming = context.blueprint_card or card
                -- six_geese_a_laying
                -- five_gold_rings
                -- four_calling_birds
                -- three_french_hens
                -- two_turtle_doves
                -- and a_partridge_in_a_pear_tree
                card_eval_status_text(seven_swans_a_swimming, "extra", nil, nil, nil, { message = localize("k_duplicated_ex") })
                return nil, true
            else
                return true
            end
        end
    end
}, true)

-- scratch-off logic
local function bof_scratch_off_reroll_boosters()
    if not G.shop_booster then
        return
    end
    local booster_cards = {}
    for i = #G.shop_booster.cards, 1, -1 do
        local c = G.shop_booster.cards[i]
        if c.ability and c.ability.set == "Booster" then
            booster_cards[#booster_cards + 1] = c
        end
    end
    local replace_count = #booster_cards
    if replace_count == 0 then
        replace_count = 1
    end
    for _, booster_card in ipairs(booster_cards) do
        G.shop_booster:remove_card(booster_card)
        booster_card:remove()
    end
    for i = 1, replace_count do
        local key = get_pack("shop_pack").key
        if key and G.P_CENTERS[key] then
            local new_card = Card(
                G.shop_booster.T.x + G.shop_booster.T.w / 2,
                G.shop_booster.T.y,
                G.CARD_W * 1.27,
                G.CARD_H * 1.27,
                G.P_CARDS.empty,
                G.P_CENTERS[key],
                { bypass_discovery_center = true, bypass_discovery_ui = true }
            )
            create_shop_card_ui(new_card, "Booster", G.shop_booster)
            new_card.ability.booster_pos = i
            new_card:start_materialize()
            G.shop_booster:emplace(new_card)
        end
    end
end

-- lottery ticket logic
local function bof_get_random_voucher_key(excluded, seed_suffix)
    local _pool, _pool_key = get_current_pool("Voucher")
    local candidates = {}
    for _, v in ipairs(_pool) do
        if v ~= "UNAVAILABLE" and (not excluded or not excluded[v]) then
            candidates[#candidates + 1] = v
        end
    end
    if #candidates == 0 then
        for _, v in ipairs(_pool) do
            if v ~= "UNAVAILABLE" then
                candidates[#candidates + 1] = v
            end
        end
    end
    if #candidates == 0 then
        return "UNAVAILABLE"
    end
    return pseudorandom_element(candidates, pseudoseed(_pool_key .. seed_suffix))
end
local function bof_lottery_ticket_reroll_vouchers()
    if not G.shop_vouchers then
        return
    end
    local voucher_cards = {}
    for i = #G.shop_vouchers.cards, 1, -1 do
        local c = G.shop_vouchers.cards[i]
        if c.ability and c.ability.set == "Voucher" then
            voucher_cards[#voucher_cards + 1] = c
        end
    end
    local replace_count = #voucher_cards
    if replace_count == 0 then
        replace_count = 1
    end
    local excluded_keys = {}
    for _, voucher_card in ipairs(voucher_cards) do
        if voucher_card.config and voucher_card.config.center_key then
            excluded_keys[voucher_card.config.center_key] = true
        end
        G.shop_vouchers:remove_card(voucher_card)
        voucher_card:remove()
    end
    G.GAME.current_round.voucher = { spawn = {} }
    for i = 1, replace_count do
        local key = bof_get_random_voucher_key(excluded_keys, "scratch_off_" .. i)
        if key == "UNAVAILABLE" or not G.P_CENTERS[key] then
            return
        end
        G.GAME.current_round.voucher[#G.GAME.current_round.voucher + 1] = key
        G.GAME.current_round.voucher.spawn[key] = true
        local new_card = Card(
            G.shop_vouchers.T.x + G.shop_vouchers.T.w / 2,
            G.shop_vouchers.T.y,
            G.CARD_W,
            G.CARD_H,
            G.P_CARDS.empty,
            G.P_CENTERS[key],
            { bypass_discovery_center = true, bypass_discovery_ui = true }
        )
        new_card.shop_voucher = true
        create_shop_card_ui(new_card, "Voucher", G.shop_vouchers)
        new_card:start_materialize()
        G.shop_vouchers:emplace(new_card)
    end
    G.shop_vouchers.config.card_limit = #G.shop_vouchers.cards
end

-- scratch-off & lottery ticket logic cont.
local bof_reroll_shop_ref = G.FUNCS.reroll_shop
if bof_reroll_shop_ref then
    G.FUNCS.reroll_shop = function(e)
        if G.GAME and G.GAME.used_vouchers and G.GAME.used_vouchers.v_bof_scratch_off then
            G.GAME.bof_scratch_off_shop_reroll_count = (G.GAME.bof_scratch_off_shop_reroll_count or 0) + 1
            if G.GAME.bof_scratch_off_shop_reroll_count >= (G.P_CENTERS.v_bof_scratch_off.config.extra.reroll_count or 3) then
                G.GAME.bof_scratch_off_shop_reroll_count = 0
                bof_scratch_off_reroll_boosters()
            end
        end
        if G.GAME and G.GAME.used_vouchers and G.GAME.used_vouchers.v_bof_lottery_ticket then
            G.GAME.bof_lottery_ticket_shop_reroll_count = (G.GAME.bof_lottery_ticket_shop_reroll_count or 0) + 1
            if G.GAME.bof_lottery_ticket_shop_reroll_count >= (G.P_CENTERS.v_bof_lottery_ticket.config.extra.reroll_count or 6) then
                G.GAME.bof_lottery_ticket_shop_reroll_count = 0
                bof_lottery_ticket_reroll_vouchers()
            end
        end
        return bof_reroll_shop_ref(e)
    end
end

-- make wooden cards not count as an enhancement
local get_enhancements_ref = SMODS.get_enhancements
function SMODS.get_enhancements(card, ...)
    local enhancements = get_enhancements_ref(card, ...)
    if enhancements then
        local filtered = {}
        for k, v in pairs(enhancements) do
            if k ~= "m_bof_wooden" then
                filtered[k] = v
            end
        end
        return filtered
    end
    return enhancements
end

-- Ensure collection tallies are refreshed whenever the mod overlay closes
if G.FUNCS.exit_mods then
    local bof_exit_mods_ref = G.FUNCS.exit_mods
    G.FUNCS.exit_mods = function(...)
        BundlesOfFun.on_exit_mods()
        return bof_exit_mods_ref(...)
    end
end

-- Wrap set_discover_tallies so our correction runs immediately after vanilla's
-- count, before the collection UIBox buttons are built. This also fixes centering
-- on first open (ref_value = "display" is non-nil when the UIBox measures itself).
local bof_set_discover_tallies_ref = set_discover_tallies
function set_discover_tallies()
    bof_set_discover_tallies_ref()
    BundlesOfFun.refresh_collection_ui()
end

-- modsCollectionTally returns { tally, of } with no .display field.
-- The UIBox_button lovely-patch reads ref_value = "display", so set it here.
-- The original also only checks `not v.no_collection` (boolean), so function-type
-- no_collection items (BundlesOfFun's approach) are always excluded. We add them back.
local bof_modsCollectionTally_ref = modsCollectionTally
function modsCollectionTally(pool, set, ignore_discovered)
    local result = bof_modsCollectionTally_ref(pool, set, ignore_discovered)
    if pool and G.ACTIVE_MOD_UI then
        for _, v in pairs(pool) do
            if v.mod and G.ACTIVE_MOD_UI.id == v.mod.id and type(v.no_collection) == "function" and not v.no_collection() then
                if set then
                    if v.set and v.set == set then
                        result.of = result.of + 1
                        if ignore_discovered or v.discovered then result.tally = result.tally + 1 end
                    end
                else
                    result.of = result.of + 1
                    if ignore_discovered or v.discovered then result.tally = result.tally + 1 end
                end
            end
        end
    end
    result.display = result.tally .. " / " .. result.of
    return result
end

-- display deck blind prediction system
-- doesn't really work right now i kinda hate everything
function BundlesOfFun.get_next_showdown_ante()
    local current_ante = G.GAME.round_resets.ante or 1
    local win_ante = G.GAME.win_ante or 8
    for i = current_ante + 1, current_ante + 8 do
        if i % win_ante == 0 then
            return i
        end
    end
    return win_ante
end

function BundlesOfFun.is_showdown_ante(ante)
    local win_ante = G.GAME and G.GAME.win_ante or 8
    return ante and ante >= 2 and win_ante > 0 and ante % win_ante == 0
end

function BundlesOfFun.is_eligible_boss_blind(blind_def, ante)
    if type(blind_def) ~= "table" or not blind_def.boss then
        return false
    end
    local win_ante = G.GAME and G.GAME.win_ante or 8
    local ante_value = math.max(1, ante or 1)
    local res, options = SMODS.add_to_pool(blind_def)
    options = options or {}
    if options.ignore_showdown_check then
        return res and true or false
    end
    local is_showdown = blind_def.boss.showdown or false
    if blind_def.in_pool and type(blind_def.in_pool) == "function" then
        if ((ante_value % win_ante == 0 and ante_value >= 2) == is_showdown) then
            return res and true or false
        end
        return false
    end
    if not is_showdown and blind_def.boss.min and blind_def.boss.min <= ante_value and (ante_value % win_ante ~= 0 or ante_value < 2) then
        return res and true or false
    end
    if is_showdown and ante_value % win_ante == 0 and ante_value >= 2 then
        return res and true or false
    end
    return false
end

function BundlesOfFun.predict_next_boss()
    local next_ante = (G.GAME.round_resets.ante or 1) + 1
    if BundlesOfFun.is_showdown_ante(next_ante) then
        G.GAME.bof_predicted_boss = nil
        G.GAME.bof_predicted_ante = nil
        G.GAME.perscribed_bosses = G.GAME.perscribed_bosses or {}
        G.GAME.perscribed_bosses[next_ante] = nil
        return
    end
    local boss_pool = {}
    for key, blind_def in pairs(G.P_BLINDS or {}) do
        if BundlesOfFun.is_eligible_boss_blind(blind_def, next_ante) then
            boss_pool[key] = blind_def
        end
    end
    local eligible_bosses = boss_pool
    G.GAME.perscribed_bosses = G.GAME.perscribed_bosses or {}
    if G.GAME.bof_predicted_ante == next_ante and G.GAME.bof_predicted_boss and eligible_bosses[G.GAME.bof_predicted_boss] then
        G.GAME.perscribed_bosses[next_ante] = G.GAME.bof_predicted_boss
    elseif next(eligible_bosses) then
        local _, boss_key = pseudorandom_element(eligible_bosses, pseudoseed("bof_display_boss_"..next_ante))
        G.GAME.bof_predicted_boss = boss_key
        G.GAME.bof_predicted_ante = next_ante
        G.GAME.perscribed_bosses[next_ante] = boss_key
    else
        G.GAME.bof_predicted_boss = nil
        G.GAME.bof_predicted_ante = nil
        G.GAME.perscribed_bosses[next_ante] = nil
    end
end

function BundlesOfFun.predict_next_showdown()
    local showdown_ante = BundlesOfFun.get_next_showdown_ante()
    G.GAME.bof_showdown_ante = showdown_ante
    local showdown_pool = {}
    for key, blind_def in pairs(G.P_BLINDS or {}) do
        if BundlesOfFun.is_eligible_boss_blind(blind_def, showdown_ante) and ((blind_def.boss and blind_def.boss.showdown) or blind_def.showdown) then
            showdown_pool[key] = blind_def
        end
    end
    if G.GAME.bof_predicted_showdown_ante == showdown_ante and G.GAME.bof_predicted_showdown and showdown_pool[G.GAME.bof_predicted_showdown] then
    elseif next(showdown_pool) then
        local _, showdown_key = pseudorandom_element(showdown_pool, pseudoseed("bof_display_showdown_"..showdown_ante))
        G.GAME.bof_predicted_showdown = showdown_key
        G.GAME.bof_predicted_showdown_ante = showdown_ante
    else
        G.GAME.bof_predicted_showdown = nil
        G.GAME.bof_predicted_showdown_ante = nil
    end
    G.GAME.perscribed_bosses = G.GAME.perscribed_bosses or {}
    if G.GAME.bof_predicted_showdown then
        G.GAME.perscribed_bosses[showdown_ante] = G.GAME.bof_predicted_showdown
    end
end

function BundlesOfFun.update_predictions()
    BundlesOfFun.predict_next_boss()
    BundlesOfFun.predict_next_showdown()
end

-- antepreview compat
local function bof_is_new_boss_preview_call()
    if type(debug) ~= "table" or type(debug.getinfo) ~= "function" then
        return false
    end
    local depth = 2
    while true do
        local info = debug.getinfo(depth, "nSl")
        if not info then
            break
        end
        local source = (info.source or ""):lower()
        local name = info.name or ""
        if source:find("antepreview", 1, true) or source:find("ante_preview", 1, true) or name == "predict_next_ante" or name == "create_ante_preview" then
            return true
        end
        depth = depth + 1
        if depth > 12 then
            break
        end
    end
    return false
end

local function bof_get_predicted_boss_for_ante(ante)
    if type(ante) ~= "number" then
        return nil
    end
    if G.GAME.perscribed_bosses and G.GAME.perscribed_bosses[ante] then
        return G.GAME.perscribed_bosses[ante]
    end
    if G.GAME.bof_predicted_ante == ante and G.GAME.bof_predicted_boss then
        return G.GAME.bof_predicted_boss
    end
    if G.GAME.bof_predicted_showdown_ante == ante and G.GAME.bof_predicted_showdown then
        return G.GAME.bof_predicted_showdown
    end
    return nil
end

function BundlesOfFun.create_predicted_blind_choice(type, blind_key, blind_ante, run_info)
    if not blind_key or not blind_ante then
        return nil
    end
    G.GAME.round_resets.blind_choices = G.GAME.round_resets.blind_choices or {}
    G.GAME.round_resets.blind_states = G.GAME.round_resets.blind_states or {}
    local old_choice = G.GAME.round_resets.blind_choices[type]
    local old_ante = G.GAME.round_resets.blind_ante
    local old_state = G.GAME.round_resets.blind_states[type]
    G.GAME.round_resets.blind_choices[type] = blind_key
    G.GAME.round_resets.blind_ante = blind_ante
    G.GAME.round_resets.blind_states[type] = "Upcoming"
    local choice = create_UIBox_blind_choice(type, run_info)
    G.GAME.round_resets.blind_choices[type] = old_choice
    G.GAME.round_resets.blind_ante = old_ante
    G.GAME.round_resets.blind_states[type] = old_state
    return choice
end

local function bof_install_get_new_boss_hook()
    if BundlesOfFun.get_new_boss_hooked then
        return
    end
    if type(get_new_boss) ~= "function" then
        return
    end
    BundlesOfFun.original_get_new_boss = get_new_boss
    get_new_boss = function(...)
        local is_preview = bof_is_new_boss_preview_call()
        if G.GAME and G.GAME.round_resets then
            local current_ante = G.GAME.round_resets.ante or 1
            if G.GAME.round_resets.boss_rerolled then
                G.GAME.perscribed_bosses = G.GAME.perscribed_bosses or {}
                G.GAME.perscribed_bosses[current_ante] = nil
            end
            local ante = current_ante
            if is_preview then
                ante = current_ante + 1
            end
            local boss = bof_get_predicted_boss_for_ante(ante)
            if boss then
                if is_preview then
                    G.GAME.bosses_used = G.GAME.bosses_used or {}
                    G.GAME.bosses_used[boss] = (G.GAME.bosses_used[boss] or 0) + 1
                    if SMODS.find_mod("cartomancer") and type(G.GAME.cartomancer_bosses_list) ~= "table" then
                        G.GAME.cartomancer_bosses_list = {}
                    end
                    return boss
                end
                G.GAME.perscribed_bosses = G.GAME.perscribed_bosses or {}
                G.GAME.perscribed_bosses[current_ante] = nil
                G.GAME.bosses_used = G.GAME.bosses_used or {}
                G.GAME.bosses_used[boss] = (G.GAME.bosses_used[boss] or 0) + 1
                return boss
            end
        end
        return BundlesOfFun.original_get_new_boss(...)
    end
    BundlesOfFun.get_new_boss_hooked = true
end

if type(G.FUNCS) == "table" and type(G.FUNCS.evaluate_round) == "function" then
    local bof_evaluate_round_ref = G.FUNCS.evaluate_round
    G.FUNCS.evaluate_round = function(...)
        bof_install_get_new_boss_hook()
        return bof_evaluate_round_ref(...)
    end
end

-- hook current_blinds to add prediction ui
local G_UIDEF_current_blinds_ref = G.UIDEF.current_blinds
function G.UIDEF.current_blinds()
    local value = G_UIDEF_current_blinds_ref()
    if G.GAME and G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == "b_bof_display" then
        G.GAME.bof_predicted_boss = G.GAME.bof_predicted_boss or nil
        G.GAME.bof_predicted_showdown = G.GAME.bof_predicted_showdown or nil
        G.GAME.bof_showdown_ante = G.GAME.bof_showdown_ante or 8
        if G.GAME.bof_predicted_ante ~= (G.GAME.round_resets.ante or 1) + 1 or not G.GAME.bof_predicted_boss then
            BundlesOfFun.predict_next_boss()
        end
        if G.GAME.bof_predicted_showdown_ante ~= G.GAME.bof_showdown_ante or not G.GAME.bof_predicted_showdown then
            BundlesOfFun.predict_next_showdown()
        end
        bof_install_get_new_boss_hook()
        local next_ante = (G.GAME.round_resets.ante or 1) + 1
        local boss_choice = BundlesOfFun.create_predicted_blind_choice("Boss", G.GAME.bof_predicted_boss, next_ante, true)
        local boss_node = boss_choice or { n = G.UIT.R, config = { align = "cm" }, nodes = { { n = G.UIT.T, config = { text = "No boss", scale = 0.35, colour = G.C.UI.TEXT_INACTIVE } } } }
        local boss_section = { n = G.UIT.C, config = { align = "tm", padding = 0.1, outline = 2, r = 0.1, line_emboss = 0.2, outline_colour = G.C.BLUE }, nodes = {
            { n = G.UIT.R, config = { align = "cm" }, nodes = { { n = G.UIT.T, config = { text = "Ante " .. next_ante, scale = 0.4, colour = G.C.BLUE, shadow = true } } } },
            boss_node
        } }
        local showdown_choice = BundlesOfFun.create_predicted_blind_choice("Boss", G.GAME.bof_predicted_showdown, G.GAME.bof_showdown_ante, true)
        local showdown_node = showdown_choice or { n = G.UIT.R, config = { align = "cm" }, nodes = { { n = G.UIT.T, config = { text = "No showdown", scale = 0.35, colour = G.C.UI.TEXT_INACTIVE } } } }
        local showdown_section = { n = G.UIT.C, config = { align = "tm", padding = 0.1, outline = 2, r = 0.1, line_emboss = 0.2, outline_colour = G.C.RED }, nodes = {
            { n = G.UIT.R, config = { align = "cm" }, nodes = { { n = G.UIT.T, config = { text = "Ante " .. G.GAME.bof_showdown_ante, scale = 0.4, colour = G.C.RED, shadow = true } } } },
            showdown_node
        } }
        local prediction_row = { n = G.UIT.C, config = { align = "cm", padding = 0.2 }, nodes = {
            boss_section,
            showdown_section
        } }
        table.insert(value.nodes, prediction_row)
    end
    return value
end

-- track fish expiration for buried treasure unlock
local original_smods_destroy_cards = SMODS.destroy_cards
function SMODS.destroy_cards(card, args)
    if card and card.ability and card.ability.set == "Fish" then
        G.GAME.bof_fish_expired = (G.GAME.bof_fish_expired or 0) + 1
        check_for_unlock({ bof_fish_expired = G.GAME.bof_fish_expired })
    end
    return original_smods_destroy_cards(card, args)
end

-- UIBox_button uses ref_value = "display" on count objects. modsCollectionTally
-- and set_discover_tallies set .display on their results, but third-party mods may
-- pass raw {tally, of} count tables that have no .display. Patch it here as a
-- catch-all so every collection button has something to render.
local bof_UIBox_button_ref = UIBox_button
function UIBox_button(args)
    if args and args.count and type(args.count) == "table" and args.count.display == nil then
        args.count.display = (args.count.tally or 0) .. " / " .. (args.count.of or 0)
    end
    return bof_UIBox_button_ref(args)
end

-- In the vanilla collection (G.ACTIVE_MOD_UI nil), consumable_collection_page uses
-- SMODS.ConsumableType.visible_buffer unfiltered, so bundle-disabled types (like
-- fish) always show a button even with 0 visible items. Filter the buffer first.
local bof_consumable_collection_page_ref = G.UIDEF.consumable_collection_page
G.UIDEF.consumable_collection_page = function(page)
    if G.ACTIVE_MOD_UI or not G.P_CENTER_POOLS then
        return bof_consumable_collection_page_ref(page)
    end
    local orig = SMODS.ConsumableType.visible_buffer
    local filtered = {}
    for _, key in ipairs(orig) do
        local pool = G.P_CENTER_POOLS[key]
        if pool and #SMODS.collection_pool(pool) > 0 then
            filtered[#filtered + 1] = key
        end
    end
    SMODS.ConsumableType.visible_buffer = filtered
    local result = bof_consumable_collection_page_ref(page)
    SMODS.ConsumableType.visible_buffer = orig
    return result
end