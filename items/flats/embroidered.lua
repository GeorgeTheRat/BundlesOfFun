BundlesOfFun.Back {
    key = "embroidered",
    name = "Embroidered Deck",
    bundle = "flats",
    config = {
        extra = {
            ranks = 4,
            cards = 4
        }
    },
    pos = { x = 3, y = 0 },
    unlocked = false,
    atlas = "deck",
    loc_vars = function(self, info_queue)
        return {
            vars = {
                self.config.extra.ranks,
                self.config.extra.cards
            }
        }
    end,
    apply = function(self, back)
        local all_ranks = {}
        for _, key in ipairs(SMODS.Rank.obj_buffer) do
            local r = SMODS.Ranks[key]
            if SMODS.add_to_pool(r, { initial_deck = true }) then -- pseudorandom_element wouldnt respect inital deck in_pool iirc
                all_ranks[#all_ranks + 1] = r
            end
        end
        G.GAME.starting_deck_size = G.GAME.starting_deck_size - (self.config.extra.ranks * 4)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = 1, self.config.extra.ranks do
                    local rank = pseudorandom_element(all_ranks, pseudoseed("bof_embroidered_1"))
                    for j, r in ipairs(all_ranks) do
                        if r == rank then
                            table.remove(all_ranks, j)
                            break
                        end
                    end
                    for _, playing_card in ipairs(G.playing_cards) do
                        if playing_card:get_id() == rank.id then
                            SMODS.destroy_cards(playing_card, { immediate = true })
                        end
                    end
                end
                return true
            end
        }))
    end,
calculate = function(self, back, context)
    if context.end_of_round and context.main_eval and context.beat_boss then
        local rank = pseudorandom_element(SMODS.Ranks, pseudoseed("bof_embroidered_2"))
        G.E_MANAGER:add_event(Event({
            func = function()
                local suits = {}
                for _, suit in pairs(SMODS.Suits) do
                    suits[#suits + 1] = suit
                end
                for i = 1, self.config.extra.cards do
                    local suit = suits[((i - 1) % #suits) + 1]
                    local new_card = SMODS.add_card({
                        suit = suit.card_key,
                        rank = rank.card_key,
                        area = G.deck,
                        set = "Base",
                        key_append = "bof_embroidered"
                    })
                    SMODS.calculate_context({ playing_card_added = true, cards = { new_card } })
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