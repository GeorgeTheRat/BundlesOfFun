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

-- make tumor tom unable to be sold when there isn't enough room in joker slots
local can_sell_card_old = G.FUNCS.can_sell_card
G.FUNCS.can_sell_card = function(e)
	local card = e.config.ref_table
	if card.config.center.key == "j_bof_j_tom" and card:can_sell_card() then
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

-- eureka logic
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

-- eureka logic cont.
SMODS.Booster:take_ownership_by_kind("Celestial", {
    update_pack = function(self, dt)
        local state_wasnt_complete = not G.STATE_COMPLETE
        SMODS.Booster.update_pack(self, dt)
        if next(SMODS.find_card("j_bof_j_eureka")) and state_wasnt_complete then
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

-- eureka logic cont.
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

-- wooden deck effect cont.
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
    if G.GAME and G.GAME.blind and self:get_id() == 14 then
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

-- wooden deck unlock cont.
local original_end_round = end_round
function end_round()
    G.GAME.bof_wooden_destroyed = 0
    return original_end_round()
end

-- retro deck: level up 4 random poker hands when a blind is skipped
local original_skip_blind = G.FUNCS.skip_blind
G.FUNCS.skip_blind = function(e)
    original_skip_blind(e)
    local back = G.GAME and G.GAME.selected_back
    if not (back and back.effect and back.effect.center and back.effect.center.key == "b_bof_l_retro") then
        return
    end
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
                local idx = pseudorandom(pseudoseed("b_bof_l_retro"), 1, #pool)
                local hand = table.remove(pool, idx)
                level_up_hand(G.deck.cards[1] or G.deck, hand, nil, 1)
            end
            return true
        end
    }))
end

-- fossilized deck: consumables in shop may rarely be negative
local original_create_card_for_shop = create_card_for_shop
function create_card_for_shop(area)
    local card = original_create_card_for_shop(area)
    local back = G.GAME and G.GAME.selected_back
    if
        card
        and area == G.shop_jokers
        and back and back.effect and back.effect.center and back.effect.center.key == "b_bof_l_fossilized"
        and card.ability and card.ability.consumeable
        and not (card.edition and card.edition.negative)
    then
        if pseudorandom(pseudoseed("b_bof_l_fossilized")) < 0.06 then
            card:set_edition({ negative = true }, true)
        end
    end
    return card
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
    if BundlesOfFun.config.custom_sounds and G.GAME and G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == "b_bof_l_wooden" then
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

-- wooden deck custom card centers
local original_card_set_sprites = Card.set_sprites
function Card:set_sprites(_center, _front)
    original_card_set_sprites(self, _center, _front)
    if
        BundlesOfFun.config.custom_wooden_center and
        G.GAME and
        G.GAME.selected_back and
        G.GAME.selected_back.effect and
        G.GAME.selected_back.effect.center and
        G.GAME.selected_back.effect.center.key == "b_bof_l_wooden" and
        self.config.center and
        self.config.center.set == "Default" and
        self.children
    then
        if self.children.center then
            self.children.center:remove()
        end
        self.children.center = SMODS.create_sprite(self.T.x, self.T.y, self.T.w, self.T.h, "bof_wooden", { x = 0, y = 0 })
        self.children.center.states.hover = self.states.hover
        self.children.center.states.click = self.states.click
        self.children.center.states.drag = self.states.drag
        self.children.center.states.collide.can = false
        self.children.center:set_role({
            major = self,
            role_type = "Glued",
            draw_major = self
        })
    end
end

-- laughing stock: reset blind stuff on new run
local original_game_start_run = Game.start_run
function Game:start_run(arg)
    if G.GAME.bof_laughing_stock_original_mult then
        for blind_key, original_mult in pairs(G.GAME.bof_laughing_stock_original_mult) do
            if G.P_BLINDS[blind_key] then
                G.P_BLINDS[blind_key].mult = original_mult
            end
        end
        G.GAME.bof_laughing_stock_original_mult = nil
    end
    return original_game_start_run(self, arg)
end

-- pianoman: force common jokers
local original_create_card = create_card
function create_card(forced_type, area, legendary, key, forced_rarity, materialize, skip_materialize, soulable, hidden, offset_y, forced_key, silent, from_buffer)
    if G.GAME.bof_pianoman_common_only and (forced_type == "Joker" or (forced_key and G.P_CENTERS[forced_key] and G.P_CENTERS[forced_key].set == "Joker")) then
        forced_type = "Joker"
        legendary = nil
        forced_rarity = 0.7
        forced_key = nil
    end
    return original_create_card(forced_type, area, legendary, key, forced_rarity, materialize, skip_materialize, soulable, hidden, offset_y, forced_key, silent, from_buffer)
end
local original_smods_create_card = SMODS.create_card
function SMODS.create_card(t)
    if G.GAME.bof_pianoman_common_only and t and (t.set == "Joker" or (t.key and G.P_CENTERS[t.key] and G.P_CENTERS[t.key].set == "Joker")) then
        t.set = "Joker"
        t.legendary = nil
        t.rarity = 0.7
        t.key = nil
    end
    return original_smods_create_card(t)
end

-- display a custom crash message when a card fails to load
local oldcardload = Card.load
function Card:load(cardTable, other_card)
    if not G.P_CENTERS[cardTable.save_fields.center] and cardTable.save_fields.center:find("bof_") then
        error("A Joker from a disabled bundle in Bundles Of Fun is present in your continued run. Please enable all bundles in the mod settings and restart Balatro.")
    end
    return oldcardload(self, cardTable, other_card)
end

-- director logic (currently tracks all triggers and i can't get it to be otherwise)
local oldsmodscalculaterepetitions = SMODS.calculate_repetitions
SMODS.calculate_repetitions = function(card, context, reps)
    card.bof_retriggered = nil
    local g = oldsmodscalculaterepetitions(card, context, reps)
    if #g >= 2 then
        card.bof_retriggered = true
    end
    return g
end

-- make it so that perkeo can't copy legendary fish
local legendary_fish_keys = {
    "c_bof_i_bass_l",
    "c_bof_i_betta_l",
    "c_bof_i_goldfish_l",
    "c_bof_i_trout_l"
}

SMODS.Joker:take_ownership("perkeo", {
    name = "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    loc_vars = function(self, info_queue, card)
        local main_end = {}
        if G.consumeables and G.consumeables.cards then
            print("consumables exists wow")
            for _, consumable in ipairs(G.consumeables.cards) do
                print("iteration")
                if consumable.config.center and consumable.config.center.key then
                    print("center key: " .. consumable.config.center.key)
                    for _, legendary_key in ipairs(legendary_fish_keys) do
                        if consumable.config.center.key == legendary_key then
                            print("wowie zowie localize go")
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
            local eligibleJokers = {}
            for k, v in pairs(G.consumeables.cards) do
                if v.ability.consumeable and not SMODS.in_scoring(v.config.center.key, legendary_fish_keys) then
                    table.insert(eligibleJokers, v)
                end
            end
            if #eligibleJokers > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local card = copy_card(pseudorandom_element(eligibleJokers, pseudoseed("perkeo")), nil)
                        card:set_edition({ negative = true }, true)
                        card:add_to_deck()
                        G.consumeables:emplace(card) 
                        return true
                    end}))
                card_eval_status_text(context_blueprint_card or card, "extra", nil, nil, nil, { message = localize("k_duplicated_ex") })
                return nil, true
            else
                return true
            end
        end
    end
}, true)

-- hotboxer shop hook
local create_card_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	if next(SMODS.find_card("j_bof_j_hotboxer")) and area == G.shop_jokers and _type ~= "Tarot" then
		if (#G.shop_jokers.cards + 1) == G.GAME.shop.joker_max then
			return create_card_ref("Tarot", area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
		end
	end
	return create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
end