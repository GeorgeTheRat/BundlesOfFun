BundlesOfFun.Joker {
    key = "stock",
    name = "Laughing Stock",
    bundle = "jesters",
    config = {
        extra = {
            blind_reduction = 5,
            enhancement = nil
        }
    },
    pos = { x = 7, y = 4 },
    attributes = { "xblindsize", "destroy_card", "enhancements" },
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local function bof_boss_colour()
            if
                G.P_BLINDS and
                G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss] and
                G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].boss_colour and
                not G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].boss.showdown
            then
                return G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].boss_colour
            else
                return G.C.ORANGE
            end
        end
        local function bof_showdown_colour()
            if
                G.P_BLINDS and
                G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss] and
                G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].boss_colour and
                G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].boss.showdown
            then
                return G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].boss_colour
            else
                return G.C.ORANGE
            end
        end
        info_queue[#info_queue + 1] = { set = "Other", key = "k_bof_blind_type", vars = { colours = { bof_boss_colour(), bof_showdown_colour() } } }
        if not card.ability.extra.enhancement then
            local counts = {}
            for _, c in ipairs(G.playing_cards or (G.deck and G.deck.cards) or {}) do
                for k in pairs(SMODS.get_enhancements(c)) do
                    counts[k] = (counts[k] or 0) + 1
                end
            end
            local best_enh, max_val = nil, 0
            if counts["m_bonus"] then
                best_enh, max_val = "m_bonus", counts["m_bonus"]
            end
            for k, v in pairs(counts) do
                if v > max_val then
                    best_enh, max_val = k, v
                end
            end
            card.ability.extra.enhancement = best_enh or "m_bonus"
        end
        local center = G.P_CENTERS[card.ability.extra.enhancement]
        local name = center and center.name or "Bonus"
        if not name:lower():find("card") then
            name = name .. " Card"
        end
        if center then
            info_queue[#info_queue + 1] = center
        end
        return {
            vars = {
                name,
                card.ability.extra.blind_reduction
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            local counts = {}
            for _, c in ipairs(G.playing_cards or G.deck.cards or {}) do
                for k in pairs(SMODS.get_enhancements(c)) do
                    counts[k] = (counts[k] or 0) + 1
                end
            end
            local best_enh, max_val = nil, 0
            if counts["m_bonus"] then
                best_enh, max_val = "m_bonus", counts["m_bonus"]
            end
            for k, v in pairs(counts) do
                if v > max_val then
                    best_enh, max_val = k, v
                end
            end
            card.ability.extra.enhancement = best_enh or "m_bonus"
        end
        if context.after then
            local target_enh, destroyed = card.ability.extra.enhancement or "m_bonus", {}
            for _, c in ipairs(context.scoring_hand or G.play.cards or {}) do
                if SMODS.get_enhancements(c)[target_enh] then
                    destroyed[#destroyed + 1] = c
                end
            end
            if #destroyed > 0 then
                for _, c in ipairs(destroyed) do
                    SMODS.destroy_cards(c)
                end
                local reduction_mult = (1 - card.ability.extra.blind_reduction * 0.01) ^ #destroyed
                local blind, blind_type = G.GAME.blind, nil
                if SMODS.find_mod("Cold-Beans") and Colonparen and Colonparen.get_blind_type then
                    blind_type = Colonparen.get_blind_type(blind)
                else
                    local b_key = blind and blind.config and blind.config.blind and blind.config.blind.key
                    if b_key == "bl_small" or blind.name == "Small Blind" then
                        blind_type = "Small"
                    elseif b_key == "bl_big" or blind.name == "Big Blind" then
                        blind_type = "Big"
                    elseif blind.config and blind.config.blind and blind.config.blind.boss then
                        blind_type = "Boss"
                    end
                end
                if blind_type then
                    local pools = {
                        Small = { bl_small = G.P_BLINDS.bl_small },
                        Big   = { bl_big = G.P_BLINDS.bl_big },
                        Teeny = G.P_TEENY_BLINDS or {},
                        CEO   = G.P_CEO_BLINDS or {}
                    }
                    if blind_type == "Boss" then
                        pools.Boss = {}
                        for k, v in pairs(G.P_BLINDS) do
                            if type(v) == "table" and (v.boss or (v.spawn_info and v.spawn_info.showdown)) then
                                pools.Boss[k] = v
                            end
                        end
                    end
                    local active_pool = pools[blind_type]
                    if active_pool then
                        G.GAME.bof_stock_original_mult = G.GAME.bof_stock_original_mult or {}
                        G.GAME.bof_stock_original_mult[blind_type] = G.GAME.bof_stock_original_mult[blind_type] or {}
                        for key, b_def in pairs(active_pool) do
                            if type(b_def) == "table" and b_def.mult then
                                if not G.GAME.bof_stock_original_mult[blind_type][key] then
                                    G.GAME.bof_stock_original_mult[blind_type][key] = b_def.mult
                                end
                                b_def.mult = b_def.mult * reduction_mult
                            end
                        end
                    end
                end
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        if G.GAME.blind then
                            G.GAME.blind.mult = (G.GAME.blind.mult or 1) * reduction_mult
                            G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.blind.mult * G.GAME.starting_params.ante_scaling
                            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        end
                        return true
                    end
                }))
                return {
                    message = localize("k_destroyed_ex")
                }
            end
        end
    end,
    in_pool = function(self)
        for _, c in ipairs(G.deck.cards or {}) do
            if next(SMODS.get_enhancements(c)) then return true end
        end
        return false
    end
}