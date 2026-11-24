local effect_pool = {
    "chips",
    "mult",
    "xmult",
    "probability",
    "spectral",
    "balance",
    "shop",
    "tag",
    "dollars",
    "hand_size",
    "discard",
    "hand"
}

local legacy_effect_names = {
    discards = "discard",
    hands = "hand"
}

local function next_effect(effect_number, used_effects)
    if effect_number + 1 >= 6 then
        return "self_destruct"
    end
    local available_effects = {}
    for _, effect in ipairs(effect_pool) do
        if not used_effects[effect] then
            available_effects[#available_effects + 1] = effect
        end
    end
    return pseudorandom_element(available_effects, pseudoseed("bof_grapes")) or "chips"
end

local function initialize(card)
    local extra = card.ability.extra
    local defaults = card.config.center.config.extra
    for key, value in pairs(defaults) do
        if extra[key] == nil then
            extra[key] = value
        end
    end
    extra.used_effects = extra.used_effects or {}
    for old_name, new_name in pairs(legacy_effect_names) do
        if extra.current_effect == old_name then
            extra.current_effect = new_name
        end
        if extra.next_effect == old_name then
            extra.next_effect = new_name
        end
        if extra[old_name] ~= nil then
            extra[new_name] = extra[old_name]
            extra[old_name] = nil
        end
        if extra.used_effects[old_name] then
            extra.used_effects[new_name] = true
            extra.used_effects[old_name] = nil
        end
    end
    if not extra.current_effect then
        extra.current_effect = pseudorandom_element(effect_pool, pseudoseed("bof_grapes")) or "chips"
        extra.effect_number = 1
    end
    extra.effect_number = extra.effect_number or 1
    extra.used_effects[extra.current_effect] = true
    extra.next_effect = extra.next_effect or next_effect(extra.effect_number, extra.used_effects)
    extra.used_effects[extra.next_effect] = true
end

local function change_persistent_effect(card, effect, direction)
    local extra = card.ability.extra
    local game = BOF.nc(G, "GAME")
    local round_resets = BOF.nc(game, "round_resets")
    if effect == "shop" and BOF.nc(game, "shop") then
        change_shop_size(direction * extra.shop_slots)
        return true
    elseif effect == "hand_size" and G.hand then
        G.hand:change_size(direction * extra.hand_size)
        return true
    elseif effect == "discard" and round_resets then
        round_resets.discards = round_resets.discards + direction * extra.discard
        ease_discard(direction * extra.discard)
        return true
    elseif effect == "hand" and round_resets then
        round_resets.hands = round_resets.hands + direction * extra.hand
        ease_hands_played(direction * extra.hand)
        return true
    end
    return false
end

local function update_effect(card)
    local extra = card.ability.extra
    if extra.current_effect == "self_destruct" then
        return false
    end
    if card.bof_grapes_applied_effect then
        change_persistent_effect(card, card.bof_grapes_applied_effect, -1)
        card.bof_grapes_applied_effect = nil
    end
    extra.current_effect = extra.next_effect
    extra.used_effects = extra.used_effects or {}
    extra.used_effects[extra.current_effect] = true
    extra.effect_number = extra.effect_number + 1
    extra.next_effect = next_effect(extra.effect_number, extra.used_effects)
    extra.used_effects[extra.next_effect] = true
    if card.bof_grapes_in_deck then
        if change_persistent_effect(card, extra.current_effect, 1) then
            card.bof_grapes_applied_effect = extra.current_effect
        end
    end
    return true
end

BundlesOfFun.Joker {
    key = "grapes",
    name = "Grapes",
    bundle = "appetizers",
    config = {
        extra = {
            chips = 50,
            mult = 15,
            xmult = 2,
            balance = 25,
            shop_slots = 1,
            dollars = 2,
            hand_size = 1,
            discard = 1,
            hand = 1
        }
    },
    pos = { x = 2, y = 0 },
    attributes = { "mult", "chips", "xmult", "mod_chance", "generation", "tag", "hands", "discard", "hand_size", "shop", "food" },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = "joker",
    set_ability = function(self, card)
        initialize(card)
    end,
    loc_vars = function(self, info_queue, card)
        local extra = card.ability.extra
        local in_collection = BOF.nc(card, "area", "config", "collection")
        local current_effect = card and not in_collection and extra.current_effect
        local vars = {
            extra.chips,
            extra.mult,
            extra.xmult,
            extra.balance,
            extra.shop_slots,
            extra.dollars,
            extra.hand_size,
            extra.discard,
            extra.hand
        }
        if card and not in_collection and extra.current_effect ~= "self_destruct" then
            info_queue[#info_queue + 1] = {
                set = "Other",
                key = "k_bof_grapes_next_" .. extra.next_effect,
                vars = vars
            }
        end
        return {
            key = current_effect and ("j_bof_grapes_" .. current_effect) or "j_bof_grapes",
            vars = vars
        }
    end,
    add_to_deck = function(self, card)
        initialize(card)
        card.bof_grapes_in_deck = true
        if change_persistent_effect(card, card.ability.extra.current_effect, 1) then
            card.bof_grapes_applied_effect = card.ability.extra.current_effect
        end
    end,
    remove_from_deck = function(self, card)
        if card.bof_grapes_applied_effect then
            change_persistent_effect(card, card.bof_grapes_applied_effect, -1)
            card.bof_grapes_applied_effect = nil
        end
        card.bof_grapes_in_deck = nil
    end,
    calculate = function(self, card, context)
        local extra = card.ability.extra
        if context.joker_main then
            if extra.current_effect == "chips" then
                return { chips = extra.chips }
            elseif extra.current_effect == "mult" then
                return { mult = extra.mult }
            elseif extra.current_effect == "xmult" then
                return { xmult = extra.xmult }
            elseif extra.current_effect == "balance" then
                return { bof_balance_percent = extra.balance }
            elseif extra.current_effect == "dollars" then
                return { dollars = extra.dollars }
            elseif extra.current_effect == "self_destruct" then
                SMODS.destroy_cards(card, { pinch_anim = true })
                return { message = localize("k_eaten_ex") }
            end
        end
        if extra.current_effect == "probability" and context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator * 2
            }
        end
        if
            card.bof_grapes_in_deck and
            extra.current_effect == "shop" and
            not card.bof_grapes_applied_effect and
            (context.setting_blind or context.ending_shop) and
            change_persistent_effect(card, "shop", 1)
        then
            card.bof_grapes_applied_effect = "shop"
        end
        if context.setting_blind then
            local consumable_cards = BOF.nc(G, "consumeables", "cards")
            local consumable_card_limit = BOF.nc(G, "consumeables", "config", "card_limit")
            if
                extra.current_effect == "spectral" and
                G.GAME and
                consumable_cards and
                consumable_card_limit and
                #consumable_cards + (G.GAME.consumeable_buffer or 0) < consumable_card_limit
            then
                G.GAME.consumeable_buffer = (G.GAME.consumeable_buffer or 0) + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card({
                            set = "Spectral",
                            key_append = "bof_grapes"
                        })
                        G.GAME.consumeable_buffer = math.max(0, G.GAME.consumeable_buffer - 1)
                        return true
                    end
                }))
                return {
                    message = localize("k_plus_spectral"),
                    colour = G.C.SECONDARY_SET.Spectral
                }
            elseif extra.current_effect == "tag" then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        add_tag(Tag(get_next_tag_key()))
                        return true
                    end
                }))
                card:juice_up(0.3, 0.5)
            end
        end
        if context.end_of_round and context.main_eval and not context.blueprint and update_effect(card) then
            return { message = localize("k_bof_grapes_change") }
        end
    end,
    joker_display_def = function()
        return {
            text = {
                {
                    border_nodes = {
                        {
                            ref_table = "card.joker_display_values",
                            ref_value = "current_text"
                        }
                    }
                }
            },
            reminder_text = {
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "next_text"
                }
            },
            calc_function = function(card)
                local extra = card.ability.extra
                local in_collection = BOF.nc(card, "area", "config", "collection")
                local effect = (in_collection and "chips") or extra.current_effect or "chips"
                local effect_vars = {
                    chips = { extra.chips },
                    mult = { extra.mult },
                    xmult = { extra.xmult },
                    balance = { extra.balance },
                    shop = { extra.shop_slots },
                    dollars = { extra.dollars },
                    hand_size = { extra.hand_size },
                    discard = { extra.discard },
                    hand = { extra.hand }
                }
                local function format_value(effect_key)
                    return localize({
                        type = "variable",
                        key = "a_bof_grapes_display_value_" .. effect_key,
                        vars = effect_vars[effect_key] or {}
                    })
                end
                local function format_name(effect_key)
                    return localize("k_bof_grapes_display_name_" .. effect_key)
                end
                local next_effect = extra.next_effect or "chips"
                card.joker_display_values.current_text = format_value(effect)
                card.joker_display_values.next_text = "(" .. format_name(next_effect) .. ")"
                card.joker_display_values.display_effect = effect
                card.joker_display_values.effect_colour = ({
                    chips = G.C.CHIPS,
                    mult = G.C.MULT,
                    probability = G.C.GREEN,
                    spectral = G.C.SECONDARY_SET.Spectral,
                    dollars = G.C.MONEY,
                    discard = G.C.RED,
                    hand = G.C.BLUE,
                    self_destruct = G.C.RED
                })[effect] or G.C.FILTER
            end,
            style_function = function(card, text, reminder_text)
                local border_node = BOF.nc(text, "children", 1)
                if not border_node then return end
                local effect = card.joker_display_values.display_effect
                local display_box = BOF.nc(reminder_text, "UIBox")
                if effect == "self_destruct" and BOF.nc(display_box, "has_reminder_text") then
                    display_box:remove_reminder_text()
                end
                local has_border = effect == "xmult" or effect == "balance"
                local border_colour = effect == "balance" and G.C.PLASMA or has_border and G.C.XMULT or G.C.CLEAR
                local border_config = border_node.config
                local padding = has_border and 0.03 or 0
                local render_padding = has_border and 0.05 or 0
                local changed = border_config.colour ~= border_colour or border_config.padding ~= padding or border_config.render_padding ~= render_padding
                border_config.colour = border_colour
                border_config.padding = padding
                border_config.render_padding = render_padding
                local text_node = BOF.nc(border_node, "children", 1)
                if text_node then
                    text_node.config.colour = has_border and G.C.WHITE or card.joker_display_values.effect_colour
                end
                return changed
            end
        }
    end
}
