BundlesOfFun.Joker {
    key = "durie",
    name = "Durie",
    bundle = "fables",
    pos = { x = 7, y = 7 },
    soul_pos = { x = 7, y = 8 },
    attributes = { "discard", "editions", "modify_card" },
    cost = 20,
    rarity = 4,
    unlocked = false,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "e_negative_playing_card", set = "Edition", config = { extra = 1 } }
    end,
    calculate = function(self, card, context)
        if context.pre_discard then
            card:juice_up(0.3, 0.5)
        end
        if context.blind_defeated then
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for _, c in ipairs(G.playing_cards) do
                if c.edition and c.edition.negative then
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.1,
                        func = function()
                            c:set_edition(nil, true, true)
                            play_sound("whoosh2", 1.2, 0.6)
                            return true
                        end
                    }))
                end
            end
        end
        if context.selling_card then
            for _, c in ipairs(G.hand.cards) do
                if c.edition and c.edition.negative then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            c:set_edition(nil, nil, nil, true)
                            return true
                        end
                    }))
                end
            end
            for _, c in ipairs(G.deck.cards) do
                if c.edition and c.edition.negative then
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.1,
                        func = function()
                            c:set_edition(nil, true, true)
                            play_sound("whoosh2", 1.2, 0.6)
                            return true
                        end
                    }))
                end
            end
        end
    end
}