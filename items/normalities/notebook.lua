SMODS.Joker {
    key = "n_notebook",
    name = "Notebook",
    config = {
        extra = { 
            dollars = 20,
            yes = false
        }
    },
    pos = { x = 5, y = 3 },
    cost = 8,
    rarity = 2,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        local function has_sticker(joker, sticker_key)
            if sticker_key == "pinned" then
                return joker.pinned
            end
            return joker.ability[sticker_key]
        end
        if context.setting_blind and not context.blueprint then
            local eligible_jokers = {}
            for _, v in ipairs(G.jokers.cards) do
                eligible_jokers[#eligible_jokers + 1] = v
            end
            if #eligible_jokers > 0 then
                local shuffled_jokers = {}
                for _, v in ipairs(eligible_jokers) do
                    shuffled_jokers[#shuffled_jokers + 1] = v
                end
                pseudoshuffle(shuffled_jokers, pseudoseed("j_bof_n_notebook"))
                local sticker_applied = false
                for _, target_joker in ipairs(shuffled_jokers) do
                    local available_stickers = {}
                    for k, v in pairs(SMODS.Stickers) do
                        if (v.original_mod and type(v.should_apply) == "function" and v:should_apply(target_joker, target_joker.config.center, target_joker.area, true) or target_joker.config.center[v.key .. "_compat"] ~= false) and not has_sticker(target_joker, k) and k ~= "tmj_pinned" then
                            table.insert(available_stickers, v)
                        end
                    end
                    if #available_stickers > 0 then
                        local sticker = pseudorandom_element(available_stickers, pseudoseed("j_bof_n_notebook"))
                        target_joker:add_sticker(sticker.key, true)
                        target_joker:juice_up()
                        card:juice_up()
                        card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_bof_sticker_applied") })
                        sticker_applied = true
                        break
                    end
                end
            end
        end
        if context.beat_boss and context.main_eval then
            card.ability.extra.yes = true
            for i = 1, 2 do 
                local eligible_jokers = {}
                for _, v in ipairs(G.jokers.cards) do
                    local has_any_sticker = false
                    for k, _ in pairs(SMODS.Stickers) do
                        if has_sticker(v, k) then
                            has_any_sticker = true
                            break
                        end
                    end
                    if has_any_sticker then
                        eligible_jokers[#eligible_jokers + 1] = v
                    end
                end
                if #eligible_jokers > 0 then
                    local target_joker = pseudorandom_element(eligible_jokers, pseudoseed("j_bof_n_notebook"))
                    local stickers_on_card = {}
                    for k, v in pairs(SMODS.Stickers) do
                        if has_sticker(target_joker, k) then
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