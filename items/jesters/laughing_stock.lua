BundlesOfFun.Joker {
    key = "laughing_stock",
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
        local selected = card.ability.extra.enhancement or "m_mult"
        local selected_name = "Mult"
        if selected and G.P_CENTERS[selected] then
            info_queue[#info_queue + 1] = G.P_CENTERS[selected]
            selected_name = G.P_CENTERS[selected].name or "Mult"
            if not selected_name:lower():find("card") then
                selected_name = selected_name .. " Card"
            end
        end
        return { vars = { selected_name, card.ability.extra.blind_reduction } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            local enhancement_counts = {}
            local cards_to_check = G.playing_cards or {}
            for _, deck_card in ipairs(cards_to_check) do
                local enhancements = SMODS.get_enhancements(deck_card)
                if next(enhancements) then
                    for key, _ in pairs(enhancements) do
                        enhancement_counts[key] = (enhancement_counts[key] or 0) + 1
                    end
                end
            end
            local enhancement = nil
            local max_count = 0
            if enhancement_counts["m_mult"] then
                enhancement = "m_mult"
                max_count = enhancement_counts["m_mult"]
            end
            for key, count in pairs(enhancement_counts) do
                if count > max_count then
                    enhancement = key
                    max_count = count
                end
            end
            if enhancement then
                card.ability.extra.enhancement = enhancement
            else
                card.ability.extra.enhancement = nil
            end
        end
        if context.after then
            local enhancement = card.ability.extra.enhancement or "m_mult"
            if enhancement then
                local enhanced_cards = {}
                for _, scored_card in ipairs(context.scoring_hand or G.play.cards or {}) do
                    local enhancements = SMODS.get_enhancements(scored_card)
                    if enhancements[enhancement] then
                        enhanced_cards[#enhanced_cards + 1] = scored_card
                    end
                end
                if #enhanced_cards > 0 then
                    local destroyed_count = #enhanced_cards
                    for _, enhanced_card in ipairs(enhanced_cards) do
                        SMODS.destroy_cards(enhanced_card)
                    end
                    local reduction_mult = (1 - card.ability.extra.blind_reduction * 0.01) ^ destroyed_count
                    local blind_type = nil
                    if SMODS.find_mod("Cold-Beans") and (Colonparen and Colonparen.get_blind_type) then
                        blind_type = Colonparen.get_blind_type(G.GAME.blind)
                    end
                    if not blind_type then
                        local blind_key = G.GAME.blind and G.GAME.blind.config and G.GAME.blind.config.blind and G.GAME.blind.config.blind.key
                        if blind_key == "bl_small" or (G.GAME.blind and G.GAME.blind.name == "Small Blind") then
                            blind_type = "Small"
                        elseif blind_key == "bl_big" or (G.GAME.blind and G.GAME.blind.name == "Big Blind") then
                            blind_type = "Big"
                        elseif G.GAME.blind and G.GAME.blind.config and G.GAME.blind.config.blind and G.GAME.blind.config.blind.boss then
                            blind_type = "Boss"
                        end
                    end
                    if blind_type then
                        local blind_pool = nil
                        if blind_type == "Small" then
                            blind_pool = { bl_small = G.P_BLINDS.bl_small }
                        elseif blind_type == "Big" then
                            blind_pool = { bl_big = G.P_BLINDS.bl_big }
                        elseif blind_type == "Boss" then
                            blind_pool = {}
                            for key, blind_def in pairs(G.P_BLINDS) do
                                if type(blind_def) == "table" and (blind_def.boss or (blind_def.spawn_info and blind_def.spawn_info.showdown)) then
                                    blind_pool[key] = blind_def
                                end
                            end
                        elseif blind_type == "Teeny" and G.P_TEENY_BLINDS then
                            blind_pool = G.P_TEENY_BLINDS
                        elseif blind_type == "CEO" and G.P_CEO_BLINDS then
                            blind_pool = G.P_CEO_BLINDS
                        end
                        if blind_pool then
                            G.GAME.bof_laughing_stock_original_mult = G.GAME.bof_laughing_stock_original_mult or {}
                            G.GAME.bof_laughing_stock_original_mult[blind_type] = G.GAME.bof_laughing_stock_original_mult[blind_type] or {}
                            for key, blind_def in pairs(blind_pool) do
                                if type(blind_def) == "table" and blind_def.mult then
                                    if not G.GAME.bof_laughing_stock_original_mult[blind_type][key] then
                                        G.GAME.bof_laughing_stock_original_mult[blind_type][key] = blind_def.mult
                                    end
                                    blind_def.mult = blind_def.mult * reduction_mult
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
        end
    end,
    in_pool = function(self, args)
        if G.deck and G.deck.cards and #G.deck.cards > 0 then
            for _, deck_card in ipairs(G.deck.cards) do
                if next(SMODS.get_enhancements(deck_card)) then
                    return true
                end
            end
        end
        return false
    end
}