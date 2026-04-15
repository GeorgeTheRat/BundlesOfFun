SMODS.Joker {
    key = "n_notebook",
    name = "Notebook",
    config = {
        extra = { 
            dollars = 25,
            yes = false
        }
    },
    pos = { x = 5, y = 3 },
    cost = 5,
    rarity = 2,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local eligible_jokers = {}
            for _, v in ipairs(G.jokers.cards) do
                eligible_jokers[#eligible_jokers + 1] = v
            end
            if #eligible_jokers > 0 then
                local target_joker = pseudorandom_element(eligible_jokers, pseudoseed("j_bof_n_notebook"))
                local available_stickers = {}
                for k, v in pairs(SMODS.Stickers) do
                    local has_sticker = target_joker.ability[k]
                    if k == "pinned" then
                        has_sticker = target_joker.pinned
                    end
                    if not has_sticker and target_joker.config[v.key .. "_compat"] ~= false and k ~= "tmj_pinned" then
                        available_stickers[#available_stickers + 1] = v
                    end
                end
                
                if #available_stickers > 0 then
                    local sticker = pseudorandom_element(available_stickers, pseudoseed("j_bof_n_notebook"))
                    target_joker:add_sticker(sticker.key, true)
                    target_joker:juice_up()
                    card:juice_up()
                    card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_bof_sticker_applied") })
                end
            end
        end
        
        if context.end_of_round and context.beat_boss and context.main_eval then
            card.ability.extra.yes = true
            for i = 1, 2 do 
                local eligible_jokers = {}
                for _, v in ipairs(G.jokers.cards) do
                    local has_sticker = false
                    for k, _ in pairs(SMODS.Stickers) do
                        local sticker_check = v.ability[k]
                        if k == "pinned" then
                            sticker_check = v.pinned
                        end
                        if sticker_check then
                            has_sticker = true
                            break
                        end
                    end
                    if has_sticker then
                        eligible_jokers[#eligible_jokers + 1] = v
                    end
                end
                if #eligible_jokers > 0 then
                    local target_joker = pseudorandom_element(eligible_jokers, pseudoseed("j_bof_n_notebook"))
                    local stickers_on_card = {}
                    for k, v in pairs(SMODS.Stickers) do
                        local has_sticker = target_joker.ability[k]
                        if k == "pinned" then
                            has_sticker = target_joker.pinned
                        end
                        if has_sticker then
                            stickers_on_card[#stickers_on_card + 1] = k
                        end
                    end
                    
                    if #stickers_on_card > 0 then
                        local sticker_to_remove = pseudorandom_element(stickers_on_card, pseudoseed("j_bof_n_notebook"))
                        target_joker:remove_sticker(sticker_to_remove, true)
                        target_joker:juice_up()
                        play_sound("tarot2", 1, 0.6)
                    end
                end
            end
        end
    end,
    calc_dollar_bonus = function(self,card)
        if card.ability.extra.yes then
            card.ability.extra.yes = false
            return card.ability.extra.dollars
        end
    end
}