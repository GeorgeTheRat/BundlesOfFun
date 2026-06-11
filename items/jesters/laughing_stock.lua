SMODS.Joker {
    key = "j_laughing_stock",
    name = "Laughing Stock",
    config = { extra = { blind_reduction = 5 } },
    pos = { x = 7, y = 5 },
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.blind_reduction } }
    end,
    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            local sealed_cards = {}
            for _, scored_card in ipairs(G.play.cards) do
                if scored_card.seal then
                    sealed_cards[#sealed_cards + 1] = scored_card
                end
            end
            if #sealed_cards > 0 then
                local destroyed_count = #sealed_cards
                for _, sealed_card in ipairs(sealed_cards) do
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.15,
                        func = function()
                            sealed_card:start_dissolve()
                            return true
                        end
                    }))
                    SMODS.destroy_cards(sealed_card)
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
                        G.GAME.bof_laughing_stock_original_mults = G.GAME.bof_laughing_stock_original_mults or {}
                        G.GAME.bof_laughing_stock_original_mults[blind_type] = G.GAME.bof_laughing_stock_original_mults[blind_type] or {}
                        for key, blind_def in pairs(blind_pool) do
                            if type(blind_def) == "table" and blind_def.mult then
                                if not G.GAME.bof_laughing_stock_original_mults[blind_type][key] then
                                    G.GAME.bof_laughing_stock_original_mults[blind_type][key] = blind_def.mult
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
                    message = localize("k_bof_destroyed")
                }
            end
        end
    end
}