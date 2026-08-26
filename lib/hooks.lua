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
	end
	return getchip(self)
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
SMODS.add_to_pool = function(prototype_obj, args)
    if BOF.nc(G.GAME, "starting_params", "no_aces") then
        if BOF.nc(args, "initial_deck") and prototype_obj.key == "Ace" then
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
function play_sound(sound_code, per, vol)
    if BundlesOfFun.config.custom_sounds and BOF.nc(G.GAME, "selected_back", "effect", "center") and G.GAME.selected_back.effect.center.key == "b_bof_wooden" then
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
    return original_play_sound(sound_code, per, vol)
end

-- reset stuff on new run
local original_game_start_run = Game.start_run
function Game:start_run(arg)
    if G.GAME.bof_stock_original_mult then
        for _, blind_table in pairs(G.GAME.bof_stock_original_mult) do
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
        G.GAME.bof_stock_original_mult = nil
    end
    G.GAME.bof_fish_extra_rounds = 0
    G.GAME.bof_fish_extra_consumable_slots = 0
    G.GAME.bof_scratch_off_shop_reroll_count = 0
    G.GAME.bof_vouchers_redeemed_this_ante = 0
    G.GAME.bof_current_ante = 1
    G.GAME.bof_nerd_guarantee_rare = nil
    G.GAME.bof_tiny_active = nil
    G.GAME.bof_tiny_scaled_ante = nil
    G.GAME.bof_particle_active = nil
    G.GAME.bof_stress_locked_ante = nil
    G.GAME.bof_risk_joker = nil
    G.GAME.bof_viscous_pending_card_id = nil
    G.GAME.bof_frequent_suit = nil
    G.GAME.bof_terminal_debuffed_rank = nil
    G.GAME.bof_terminal_pending_rank = nil
    G.GAME.bof_resistance_active = nil
    G.GAME.bof_angle_base_chips = nil
    G.GAME.bof_angle_discarded_cards = nil
    G.PROFILES[G.SETTINGS.profile].career_stats.bof_boosters_skipped = G.PROFILES[G.SETTINGS.profile].career_stats.bof_boosters_skipped or 0
    return original_game_start_run(self, arg)
end

-- tiny: the blind-select screen preview (used by the lovely/enemies.toml
-- patch to functions/UI_definitions.lua) computes its own chip amount
-- independently of Blind:set_blind, so it needs the same multiplier applied
-- here to match what the fight will actually require. bof_tiny_active only
-- covers the "about to be faced" case - it gets cleared the moment the Small
-- Blind is actually set, so re-viewing an already-Defeated Small Blind for
-- this same ante (e.g. via the Run Info panel) also needs to check
-- bof_tiny_scaled_ante, which remembers which ante got scaled and isn't
-- cleared until the next run.
function BundlesOfFun.blind_amount_preview(blind_choice, amount)
    if blind_choice == 'Small' and (G.GAME.bof_tiny_active or G.GAME.bof_tiny_scaled_ante == G.GAME.round_resets.ante) then
        amount = math.floor(amount * 1.5)
    end
    return amount
end

-- tiny: Small Blind next Ante is 1.5x as large (applied when it is faced)
-- particle: flag cleared once the next Ante's boss is reached
-- stress: voucher lock applies to every shop through the whole next Ante
--   (Small, Big, and its Boss), not just the first one - see the
--   bof_stress_locked_ante comment near where it's set, in stress.lua
local original_blind_set_blind = Blind.set_blind
function Blind:set_blind(blind, reset, silent)
    local ret = original_blind_set_blind(self, blind, reset, silent)
    if not reset and BOF.nc(blind, "key") then
        if blind.key == "bl_small" and G.GAME.bof_tiny_active then
            self.chips = math.floor(self.chips * 1.5)
            self.chip_text = number_format(self.chips)
            G.GAME.bof_tiny_scaled_ante = G.GAME.round_resets.ante
            G.GAME.bof_tiny_active = nil
        end
        if blind.boss and G.GAME.bof_particle_active then
            G.GAME.bof_particle_active = nil
        end
        if blind.boss and G.GAME.bof_stress_locked_ante and G.GAME.round_resets.ante > G.GAME.bof_stress_locked_ante then
            G.GAME.bof_stress_locked_ante = nil
        end
    end
    return ret
end

-- stress: no voucher restocks anywhere in the locked Ante (Voucher Tags still
-- call with _from_tag). The lock is scoped by ante number rather than a plain
-- boolean so it naturally stays active across the Small Blind shop, the Big
-- Blind shop, AND the Boss's shop of that same Ante, only lifting once we've
-- actually moved into the ante after that (see Blind:set_blind above).
function BundlesOfFun.stress_locked()
    return G.GAME and G.GAME.bof_stress_locked_ante and G.GAME.round_resets
        and G.GAME.round_resets.ante == G.GAME.bof_stress_locked_ante
end

local original_get_next_voucher_key = get_next_voucher_key
function get_next_voucher_key(_from_tag)
    if not _from_tag and BundlesOfFun.stress_locked() then
        return nil
    end
    return original_get_next_voucher_key(_from_tag)
end

-- stress: blocks the shop card, not SMODS.get_next_vouchers/current_round.voucher
-- itself - vanilla Card:redeem() unconditionally indexes current_round.voucher[1]
-- for Voucher Tag purchases, so leaving that empty would crash the tag purchase.
-- Voucher Tags create their card directly (not via add_voucher_to_shop) anyway,
-- so they're unaffected by this block either way.
local original_add_voucher_to_shop = SMODS.add_voucher_to_shop
function SMODS.add_voucher_to_shop(key, dont_save)
    if BundlesOfFun.stress_locked() then
        return
    end
    return original_add_voucher_to_shop(key, dont_save)
end

-- resistance: no payout from the blind, hands, interest, or discards at end of round,
-- joker bonuses are untouched. Flag is set by resistance.lua's calculate() on
-- context.end_of_round (which fires before the payout screen). money_per_discard
-- is what actually gates the discard bonus row (there's no no_extra_discard_money
-- the way hands has no_extra_hand_money), so it's cleared instead of flagged off.
-- no_interest short-circuits vanilla's whole interest block (row, dollars, AND
-- the interest-cap-streak stat), so nothing partial leaks through.
local original_evaluate_round = G.FUNCS.evaluate_round
G.FUNCS.evaluate_round = function()
    if G.GAME and G.GAME.bof_resistance_active then
        local original_blind_dollars = G.GAME.blind.dollars
        local original_no_extra_hand_money = G.GAME.modifiers.no_extra_hand_money
        local original_money_per_discard = G.GAME.modifiers.money_per_discard
        local original_no_interest = G.GAME.modifiers.no_interest
        G.GAME.blind.dollars = 0
        G.GAME.modifiers.no_extra_hand_money = true
        G.GAME.modifiers.money_per_discard = nil
        G.GAME.modifiers.no_interest = true
        original_evaluate_round()
        G.GAME.blind.dollars = original_blind_dollars
        G.GAME.modifiers.no_extra_hand_money = original_no_extra_hand_money
        G.GAME.modifiers.money_per_discard = original_money_per_discard
        G.GAME.modifiers.no_interest = original_no_interest
        G.GAME.bof_resistance_active = nil
        return
    end
    return original_evaluate_round()
end

-- dense: clears the bof_dense_marked flag from every card in G.play/G.hand/
-- G.discard/G.deck (wherever a marked card from a previous hand might now
-- be), un-debuffing it via SMODS.recalc_debuff on the way. Deliberately does
-- NOT track "the current target" via a card reference in G.GAME (see
-- items/enemies/dense.lua for why); shared with dense.lua's
-- blind_defeated/blind_disabled cleanup.
function BundlesOfFun.dense_clear_marks()
    for _, area in ipairs({ G.deck, G.hand, G.play, G.discard }) do
        if BOF.nc(area, "cards") then
            for _, card in ipairs(area.cards) do
                if card.ability and card.ability.bof_dense_marked then
                    card.ability.bof_dense_marked = nil
                    SMODS.recalc_debuff(card)
                end
            end
        end
    end
end

-- random & dense: both need G.play.cards to already contain the full played
-- hand. context.press_play fires as soon as Blind:press_play() is called, but
-- that happens synchronously right after queuing the (delayed/animated)
-- draw_card events that move cards from G.hand to G.play - those haven't
-- resolved yet, so G.play.cards can still be empty or partial at that point.
-- G.FUNCS.evaluate_play is the first point after that where G.play.cards is
-- guaranteed to be the complete, final played hand, so both blinds hook it
-- here instead of using their own calculate() for this part.
local original_evaluate_play = G.FUNCS.evaluate_play
G.FUNCS.evaluate_play = function(e)
    if BOF.nc(G.GAME, "blind", "config", "blind") and not G.GAME.blind.disabled 
        and G.GAME.blind.config.blind then
        if G.GAME.blind.config.blind.key == "bl_bof_dense" then
            BundlesOfFun.dense_clear_marks()
            local _, _, _, scoring_hand = G.FUNCS.get_poker_hand_info(G.play.cards)
            local target = nil
            for _, card in ipairs(G.play.cards) do
                if SMODS.in_scoring(card, scoring_hand) then
                    target = card
                    break
                end
            end
            if target then
                target.ability.bof_dense_marked = true
                SMODS.recalc_debuff(target)
                target:juice_up()
                G.GAME.blind:wiggle()
            end
        end
    end
    return original_evaluate_play(e)
end

-- frequent: update most common suit at the beginning of each ante
local original_ease_ante = ease_ante
function ease_ante(mod)
    local ret = original_ease_ante(mod)
    if G.GAME and G.playing_cards then
        local suit_counts = {}
        for _, c in ipairs(G.playing_cards) do
            local s = c.base.suit
            suit_counts[s] = (suit_counts[s] or 0) + 1
        end
        -- seeding the accumulator with Spades means a tie can't dethrone it (strict >),
        -- instead of falling to whatever pairs()'s unordered iteration visits first
        local most_common, most_count = "Spades", (suit_counts["Spades"] or 0)
        for suit, count in pairs(suit_counts) do
            if count > most_count then
                most_common = suit
                most_count = count
            end
        end
        G.GAME.bof_frequent_suit = most_common
    end
    return ret
end
-- decay: hand cards stay draggable but always ease back to their original slot.
-- set_ranks is called whenever the hand's composition/order actually changes, so it's
-- the right point to (re)capture the canonical order as a locked index per card.
local original_set_ranks = CardArea.set_ranks
function CardArea:set_ranks()
    original_set_ranks(self)
    if self == G.hand and BOF.nc(G.GAME, "blind", "config", "blind") and G.GAME.blind.config.blind.key == "bl_bof_decay_b"
        and not G.GAME.blind.disabled then
        for k, card in ipairs(self.cards) do
            card.bof_decay_locked_index = k
        end
    end
end

-- align_cards only skips T.x/T.y assignment for the card currently being dragged (drag
-- physics owns its position directly); it's vanilla's own post-loop table.sort (based on
-- live x position) that permanently reorders self.cards, which is what makes a drop
-- "stick" as a reorder. Re-sorting back to the locked index every frame means the array
-- order never actually changes, so a dropped card eases back to its original slot on
-- the next align_cards call - draggable, but always snaps back.
local original_align_cards = CardArea.align_cards
function CardArea:align_cards()
    original_align_cards(self)
    if self == G.hand and BOF.nc(G.GAME, "blind", "config", "blind") and G.GAME.blind.config.blind.key == "bl_bof_decay_b"
        and not G.GAME.blind.disabled then
        table.sort(self.cards, function(a, b)
            return (a.bof_decay_locked_index or 0) < (b.bof_decay_locked_index or 0)
        end)
    end
end

-- track voucher purchases for lottery ticket unlock
local original_use_card = G.FUNCS.use_card
function G.FUNCS.use_card(e, mute, nosave)
    local card = e.config.ref_table
    local result = original_use_card(e, mute, nosave)
    if BOF.nc(card, "ability") and card.ability.set == "Voucher" and card.area == G.shop_vouchers then
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
-- tiny/particle blinds can make upcoming blinds unskippable
-- the skip button UI consults these to hide the skip button (and reward) for
-- blinds that cannot be skipped
function BundlesOfFun.blind_skip_locked(blind_choice)
    if not G.GAME then return false end
    if G.GAME.bof_tiny_active then
        -- Only the Small Blind itself is unskippable; Big is unaffected
        return blind_choice == 'Small'
    end
    if G.GAME.bof_particle_active and (blind_choice == 'Small' or blind_choice == 'Big') then return true end
    return false
end

-- when locked, the ENTIRE tag UI (icon, "or" text, and this button) is
-- hidden by the create_UIBox_blind_tag hook below, so this function only ever
-- needs to handle the two vanilla cases (skippable / run_info review screen).
function BundlesOfFun.blind_skip_ui(blind_choice, run_info, _tag)
    if not run_info then
        return { n = G.UIT.C, config = { align = "cm", colour = G.C.UI.BACKGROUND_INACTIVE, minh = 0.6, minw = 2, maxw = 2, padding = 0.07, r = 0.1, shadow = true, hover = true, one_press = true, button = 'skip_blind', func = 'hover_tag_proxy', ref_table = _tag }, nodes = {
            { n = G.UIT.T, config = { text = localize('b_skip_blind'), scale = 0.4, colour = G.C.UI.TEXT_INACTIVE } }
        } }
    else
        return { n = G.UIT.C, config = { align = "cm", padding = 0.1, emboss = 0.05, colour = mix_colours(G.C.BLUE, G.C.BLACK, 0.4), r = 0.1, maxw = 2 }, nodes = {
            { n = G.UIT.T, config = { text = localize('b_skip_reward'), scale = 0.35, colour = G.C.WHITE } },
        } }
    end
end

-- tiny/particle: hide the whole tag/skip UI block (icon + "or" text + skip
-- button, or on the Run Info panel, the read-only reward-preview box vanilla
-- shows instead) for blind choices that cannot be skipped. On the live
-- blind-select screen this also sidesteps the vanilla button-handler code
-- that expects that UI block to exist when a tag is present; on Run Info,
-- it stops the reward preview from implying a skip that was never possible.
local original_create_UIBox_blind_tag = create_UIBox_blind_tag
function create_UIBox_blind_tag(blind_choice, run_info)
    if BundlesOfFun.blind_skip_locked(blind_choice) then
        return nil
    end
    return original_create_UIBox_blind_tag(blind_choice, run_info)
end

local original_skip_blind = G.FUNCS.skip_blind
G.FUNCS.skip_blind = function(e)
    local blind_on_deck = BOF.nc(G.GAME, "blind_on_deck")
    if (G.GAME.bof_tiny_active and blind_on_deck == 'Small')
        or (G.GAME.bof_particle_active and (blind_on_deck == 'Small' or blind_on_deck == 'Big')) then
        return
    end
    original_skip_blind(e)
    local back = G.GAME and G.GAME.selected_back
    if BOF.nc(back, "effect", "center") and back.effect.center.key == "b_bof_retro" then
        local amount = BOF.nc(back.effect.center.config, "extra", "hands") or 4
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
    if next(SMODS.find_card("j_bof_hotboxer")) and BOF.nc(G.shop_jokers, "cards") and area == G.shop_jokers and _type ~= "Tarot" then
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
    local extra_rounds = BOF.nc(G.GAME, "bof_fish_extra_rounds") or 0
    local extra_slots = BOF.nc(G.GAME, "bof_fish_extra_consumable_slots") or 0
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

-- dominant: seals have no effect - Red retrigger, Gold $3, Purple
-- tarot-on-discard, Blue end-of-round planet, all suppressed by hiding self.seal
-- for the one vanilla call that reads it, then putting it back (touching the
-- real field would desync the sprite/save state)
local function bof_dominant_active()
    return G.GAME and G.GAME.blind and not G.GAME.blind.disabled and G.GAME.blind.config
        and G.GAME.blind.config.blind and G.GAME.blind.config.blind.key == "bl_bof_dominant"
end

local dominant_calculate_seal = Card.calculate_seal
function Card:calculate_seal(context, ...)
    if bof_dominant_active() and self.seal then
        local seal = self.seal
        self.seal = nil
        local a, b = dominant_calculate_seal(self, context, ...)
        self.seal = seal
        return a, b
    end
    return dominant_calculate_seal(self, context, ...)
end

local dominant_get_p_dollars = Card.get_p_dollars
function Card:get_p_dollars()
    if bof_dominant_active() and self.seal then
        local seal = self.seal
        self.seal = nil
        local ret = dominant_get_p_dollars(self)
        self.seal = seal
        return ret
    end
    return dominant_get_p_dollars(self)
end

local dominant_get_end_of_round_effect = Card.get_end_of_round_effect
function Card:get_end_of_round_effect(context)
    if bof_dominant_active() and self.seal then
        local seal = self.seal
        self.seal = nil
        local ret = dominant_get_end_of_round_effect(self, context)
        self.seal = seal
        return ret
    end
    return dominant_get_end_of_round_effect(self, context)
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
    -- did i genuinely just get rick rolled by a take_ownership call for perkeo
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
        local main_end = {}
        if G.consumeables and G.consumeables.cards then
            for _, consumable in ipairs(G.consumeables.cards) do
                if BOF.nc(consumable.config.center, "key") then
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
                -- on the sixth day of christmas, my true love gave to me
                local eight_maids_a_milking = context.blueprint_card or card
                -- seven_swans_a_swimming
                -- six_geese_a_laying
                -- five_gold_rings
                -- four_calling_birds
                -- three_french_hens
                -- two_turtle_doves
                -- and a_partridge_in_a_pear_tree
                card_eval_status_text(eight_maids_a_milking, "extra", nil, nil, nil, { message = localize("k_duplicated_ex") })
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
    -- Lottery Ticket's own "every 6 shop rerolls" ability - replaces the shop's voucher
    -- card(s) directly instead of going through add_voucher_to_shop, so without this
    -- check it was the one way a new voucher could sneak into a locked shop
    if BundlesOfFun.stress_locked() then return end
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
        if BOF.nc(voucher_card.config, "center_key") then
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

-- postman: first four played cards count as additional suits
local original_smeared_check = SMODS.smeared_check
function SMODS.smeared_check(card, suit)
    if next(SMODS.find_card("j_bof_postman")) then
        if G.play and G.play.cards then
            for i, played_card in ipairs(G.play.cards) do
                if played_card == card and i <= 4 then
                    local postman_suits = { "Spades", "Hearts", "Clubs", "Diamonds" }
                    local assigned_suit = postman_suits[i]
                    if suit == assigned_suit then
                        return true
                    end
                end
            end
        end
        if G.hand and G.hand.highlighted then
            local highlighted_copy = {}
            for _, c in ipairs(G.hand.highlighted) do
                table.insert(highlighted_copy, c)
            end
            table.sort(highlighted_copy, function(a, b) return a.T.x < b.T.x end)
            for i, highlighted_card in ipairs(highlighted_copy) do
                if highlighted_card == card and i <= 4 then
                    local postman_suits = { "Spades", "Hearts", "Clubs", "Diamonds" }
                    local assigned_suit = postman_suits[i]
                    if suit == assigned_suit then
                        return true
                    end
                end
            end
        end
    end
    
    return original_smeared_check(card, suit)
end

-- postman: trigger poker hand check when cards are released or sorted
local original_card_release = Node.release
function Node:release(dragged)
    local result = original_card_release(self, dragged)
    if next(SMODS.find_card("j_bof_postman")) and dragged:is(Node) and dragged.area == G.hand then
        G.E_MANAGER:add_event(Event({
            func = function()
                G.hand:parse_highlighted()
                return true
            end
        }))
        
    end
    return result
end
local original_sort_hand_suit = G.FUNCS.sort_hand_suit
function G.FUNCS.sort_hand_suit(e)
    local result = original_sort_hand_suit(e)
    if next(SMODS.find_card("j_bof_postman")) then
        G.E_MANAGER:add_event(Event({
            func = function()
                G.hand:parse_highlighted()
                return true
            end
        }))
    end
    return result
end
local original_sort_hand_value = G.FUNCS.sort_hand_value
function G.FUNCS.sort_hand_value(e)
    local result = original_sort_hand_value(e)
    if next(SMODS.find_card("j_bof_postman")) then
        G.E_MANAGER:add_event(Event({
            func = function()
                G.hand:parse_highlighted()
                return true
            end
        }))
    end
    return result
end

-- scratch-off & lottery ticket logic cont.
local bof_reroll_shop_ref = G.FUNCS.reroll_shop
if bof_reroll_shop_ref then
    G.FUNCS.reroll_shop = function(e)
        if BOF.nc(G.GAME, "used_vouchers", "v_bof_scratch_off") then
            G.GAME.bof_scratch_off_shop_reroll_count = (G.GAME.bof_scratch_off_shop_reroll_count or 0) + 1
            if G.GAME.bof_scratch_off_shop_reroll_count >= (G.P_CENTERS.v_bof_scratch_off.config.extra.reroll_count or 3) then
                G.GAME.bof_scratch_off_shop_reroll_count = 0
                bof_scratch_off_reroll_boosters()
            end
        end
        if BOF.nc(G.GAME, "used_vouchers", "v_bof_lottery_ticket") then
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
-- rather than guessing what the next boss/showdown will be (which could
-- desync from the real pick, see the git history on this block), we
-- actually generate them ahead of time using SMODS's real selection logic
-- (SMODS.poll_object, the same call Steamodded's own "Bypass get_new_boss()"
-- patch uses) and stash the result in G.GAME.perscribed_bosses. that table
-- is a real vanilla field - vanilla's get_new_boss (patched in place by
-- Steamodded, not replaced) already checks it before rolling fresh, so
-- nothing else needs to hook into boss selection to make a pregenerated
-- entry actually get used once its ante comes around
function BundlesOfFun.get_next_showdown_ante()
    local current_ante = G.GAME.round_resets.ante or 1
    local win_ante = G.GAME.win_ante or 8
    for i = current_ante + 1, current_ante + win_ante do
        if i % win_ante == 0 then
            return i
        end
    end
    return win_ante
end

-- generates target_ante's boss for real via SMODS.poll_object (temporarily
-- pointing round_resets.ante at it, since that's what SMODS.create_blind_pool
-- and SMODS.is_showdown_ante read to decide eligibility/showdown-ness) and
-- locks it into perscribed_bosses. deliberately does NOT bump
-- G.GAME.bosses_used here - vanilla's get_new_boss bumps it once, for real,
-- when it actually consumes this preseeded entry; bumping here too would
-- double-count this boss as "used" against the anti-repeat weighting for a
-- single real fight. safe to call repeatedly - it's a no-op once an ante's
-- entry exists
local function bof_pregenerate_boss(target_ante)
    if type(target_ante) ~= "number" then
        return
    end
    G.GAME.perscribed_bosses = G.GAME.perscribed_bosses or {}
    if G.GAME.perscribed_bosses[target_ante] then
        return
    end
    local saved_ante = G.GAME.round_resets.ante
    G.GAME.round_resets.ante = target_ante
    local ok, boss = pcall(SMODS.poll_object, { type = "Blind", seed = "boss" })
    G.GAME.round_resets.ante = saved_ante
    if ok and boss then
        G.GAME.perscribed_bosses[target_ante] = boss
    end
end

-- the moment the real ante's boss is decided, also generate next ante's
-- boss (and the next showdown's, if further out) so the display deck can
-- show the real answer instead of a guess
local original_reset_blinds = reset_blinds
function reset_blinds()
    original_reset_blinds()
    if G.GAME and G.GAME.round_resets and G.GAME.round_resets.ante then
        bof_pregenerate_boss(G.GAME.round_resets.ante + 1)
        bof_pregenerate_boss(BundlesOfFun.get_next_showdown_ante())
    end
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

-- hook current_blinds to add prediction ui
local G_UIDEF_current_blinds_ref = G.UIDEF.current_blinds
function G.UIDEF.current_blinds()
    local value = G_UIDEF_current_blinds_ref()
    if G.GAME and G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == "b_bof_display" then
        G.GAME.perscribed_bosses = G.GAME.perscribed_bosses or {}
        local next_ante = (G.GAME.round_resets.ante or 1) + 1
        local showdown_ante = BundlesOfFun.get_next_showdown_ante()
        bof_pregenerate_boss(next_ante)
        bof_pregenerate_boss(showdown_ante)

        local boss_choice = BundlesOfFun.create_predicted_blind_choice("Boss", G.GAME.perscribed_bosses[next_ante], next_ante, true)
        local boss_node = boss_choice or { n = G.UIT.R, config = { align = "cm" }, nodes = { { n = G.UIT.T, config = { text = "No boss", scale = 0.35, colour = G.C.UI.TEXT_INACTIVE } } } }
        local boss_section = { n = G.UIT.C, config = { align = "tm", padding = 0.1, outline = 2, r = 0.1, line_emboss = 0.2, outline_colour = G.C.BLUE }, nodes = {
            { n = G.UIT.R, config = { align = "cm" }, nodes = { { n = G.UIT.T, config = { text = "Ante " .. next_ante, scale = 0.4, colour = G.C.BLUE, shadow = true } } } },
            boss_node
        } }
        local showdown_choice = BundlesOfFun.create_predicted_blind_choice("Boss", G.GAME.perscribed_bosses[showdown_ante], showdown_ante, true)
        local showdown_node = showdown_choice or { n = G.UIT.R, config = { align = "cm" }, nodes = { { n = G.UIT.T, config = { text = "No showdown", scale = 0.35, colour = G.C.UI.TEXT_INACTIVE } } } }
        local showdown_section = { n = G.UIT.C, config = { align = "tm", padding = 0.1, outline = 2, r = 0.1, line_emboss = 0.2, outline_colour = G.C.RED }, nodes = {
            { n = G.UIT.R, config = { align = "cm" }, nodes = { { n = G.UIT.T, config = { text = "Ante " .. showdown_ante, scale = 0.4, colour = G.C.RED, shadow = true } } } },
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

-- durie: make cards negative instead of discarding
local original_discard = G.FUNCS.discard_cards_from_highlighted
G.FUNCS.discard_cards_from_highlighted = function(e, hook)
    if next(SMODS.find_card("j_bof_durie")) then
        G.CONTROLLER.interrupt.focus = true
        G.CONTROLLER:save_cardarea_focus("hand")
        for k, v in ipairs(G.playing_cards) do
            v.ability.forced_selection = nil
        end
        local selected = G.hand.highlighted
        if #selected > 0 then
            SMODS.calculate_context({ durie = true })
            for _, card in ipairs(selected) do
                if not (card.edition and card.edition.negative) then
                    card:set_edition("e_negative", nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:juice_up(1, 0.5)
                            return true
                        end
                    }))
                end
            end
            play_sound("negative", 1.5, 0.4)
            G.hand:unhighlight_all()
            ease_discard(-1)
            G.GAME.current_round.discards_used = G.GAME.current_round.discards_used + 1
            G.STATE = G.STATES.DRAW_TO_HAND
            G.E_MANAGER:add_event(Event({
                trigger = "immediate",
                func = function()
                    G.STATE_COMPLETE = false
                    return true
                end
            }))
            return
        end
    end
    return original_discard(e, hook)
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
