-- Suits will be selected in sequence until you have 4 unique suits, from there it should be 100% random
-- Also it take me so long to make this one work as I intended T_T
-- You're supposed to have the chance to start with custom suits, but Bunco disables his suits by default, so only paperback and other mod that do no know/use xd
SMODS.Back {
	key = "l_display",
    name = "Display Deck",
	atlas = "deck",
	pos = { x = 5, y = 0 },
    unlocked = false,
    initial_deck = { Suits = { "Hearts" } },
    loc_vars = function(self, info_queue)
		return { vars = {} }
	end,
    apply = function(self, back)
        local all_suits = {}
        for _, key in ipairs(SMODS.Suit.obj_buffer) do
            local s = SMODS.Suits[key]
            if SMODS.add_to_pool(s, { initial_deck = true }) then
                all_suits[#all_suits + 1] = s
            end
        end
        local suit = pseudorandom_element(all_suits, pseudoseed("bof_display_initial"))
        self.initial_deck.Suits = { suit.key }
        G.GAME.bof_display_initial_card_key = suit.card_key
    end,
    calculate = function(self, back, context)
        if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss then
            if not G.GAME.bof_display_used_suits then
                G.GAME.bof_display_used_suits = { [G.GAME.bof_display_initial_card_key or "H"] = true }
            end
            local available = {}
            for _, key in ipairs(SMODS.Suit.obj_buffer) do
                local s = SMODS.Suits[key]
                if not G.GAME.bof_display_used_suits[s.card_key] then
                    available[#available + 1] = s
                end
            end
            if #available == 0 then
                G.GAME.bof_display_used_suits = {}
                for _, key in ipairs(SMODS.Suit.obj_buffer) do
                    available[#available + 1] = SMODS.Suits[key]
                end
            end
            local suit = pseudorandom_element(available, pseudoseed("bof_display_suit"))
            G.GAME.bof_display_used_suits[suit.card_key] = true
            local suit_key = suit.card_key
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _, rank in pairs(SMODS.Ranks) do
                        local front = G.P_CARDS[suit_key .. "_" .. rank.card_key]
                        if front then
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            local new_card = create_playing_card({ front = front }, G.deck, true, nil, nil)
                            new_card:add_to_deck()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                        end
                    end
                    return true
                end
            }))
        end
    end,
    -- I think it needs a bit more testing but looks like is working
    check_for_unlock = function(self, args)
        if args and args.type == "modify_deck" and G.GAME and G.GAME.blind then
            local ranks = {}
            local count = 0
            for _, card in ipairs(G.playing_cards or {}) do
                local id = card.base and card.base.id
                if id and not ranks[id] then
                    ranks[id] = true
                    count = count + 1
                    if count > 1 then return false end
                end
            end
            if count == 1 then
                unlock_card(self)
                return true
            end
        end
        return false
    end
}
