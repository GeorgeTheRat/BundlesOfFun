SMODS.Back {
	key = "l_embroidered",
    name = "Embroidered Deck",
    pos = { x = 3, y = 0 },
    unlocked = false,
    atlas = "deck",
    apply = function(self, back)
        local all_ranks = {}
        for _, key in ipairs(SMODS.Rank.obj_buffer) do
            local r = SMODS.Ranks[key]
            if SMODS.add_to_pool(r, { initial_deck = true }) then -- pseudorandom_element wouldnt respect inital deck in_pool iirc
                all_ranks[#all_ranks + 1] = r
            end
        end
        G.E_MANAGER:add_event(Event({
            func = function()
                local rank = pseudorandom_element(all_ranks, pseudoseed("bof_embroidered_inital_rank"))
                for _, playing_card in ipairs(G.playing_cards) do
                    if playing_card:get_id() == rank.id then
                        SMODS.destroy_cards(playing_card, nil, true)
                    end
                end
                return true
            end
        }))
    end,
    calculate = function(self, back, context)
        if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss then
            local rank = pseudorandom_element(SMODS.Ranks, pseudoseed("bof_embroidered_added_rank"))
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _, suit in pairs(SMODS.Suits) do
                        local front = G.P_CARDS[suit.card_key .. "_" .. rank.card_key]
                        if front then
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            local new_card = create_playing_card({ front = front }, G.deck, true, nil, nil)
                            new_card:add_to_deck()
                            G.deck:emplace(new_card)
                            new_card:start_materialize()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            table.insert(G.playing_cards, new_card)
                            new_card.states.visible = nil
                            SMODS.calculate_context({ playing_card_added = true, cards = { new_card } })
                        end
                    end
                    return true
                end
            }))
        end
    end,
    check_for_unlock = function(self, args)
        return args.type == "modify_deck" and G.deck and G.deck.config.card_limit >= 80
    end
}
