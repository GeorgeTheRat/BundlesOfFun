-- Suits will be selected in sequence until you have 4 unique suits, from there it should be 100% random
BundlesOfFun.Back {
	key = "display",
    name = "Display Deck",
    bundle = "flats",
	pos = { x = 5, y = 0 },
    unlocked = false,
    atlas = "deck",
    initial_deck = { Suits = { "Hearts" } },
    apply = function(self, back)
        local all_suits = {}
        for _, key in ipairs(SMODS.Suit.obj_buffer) do
            local s = SMODS.Suits[key]
            if SMODS.add_to_pool(s, { initial_deck = true }) then
                all_suits[#all_suits + 1] = s
            end
        end
        local suit = pseudorandom_element(all_suits, pseudoseed("b_bof_display"..os.time()))
        self.initial_deck = { Suits = { suit.key } }
        G.GAME.bof_display_initial_card_key = suit.card_key
    end,
    calculate = function(self, back, context)
        if context.end_of_round and context.main_eval and context.beat_boss then
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
            local suit = pseudorandom_element(available, pseudoseed("b_bof_display"))
            G.GAME.bof_display_used_suits[suit.card_key] = true
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _, rank in pairs(SMODS.Ranks) do
                        local new_card = SMODS.add_card({
                            suit = suit.card_key,
                            rank = rank.card_key,
                            area = G.deck,
                            set = "Base",
                            key_append = "b_bof_display"
                        })
                        SMODS.calculate_context({ playing_card_added = true, cards = { new_card } })
                    end
                    return true
                end
            }))
        end
    end,
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
                return true
            end
        end
    end
}
