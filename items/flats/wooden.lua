BundlesOfFun.Back {
	key = "wooden",
    name = "Wooden Deck",
    bundle = "flats",
    config = { remove_aces = true, extra_cards = { 2, 3, 4, 5 } },
	atlas = "deck",
	pos = { x = 2, y = 0 },
    unlocked = false,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, playing_card in ipairs(G.playing_cards) do
                    playing_card:set_ability("m_bof_wooden", nil, nil)
                end
                return true
            end
        }))
    end,
    check_for_unlock = function(self, args)
        return args and args.b_bof_wooden
    end
}

SMODS.Enhancement {
    key = "wooden",
    name = "Wooden",
    config = { bonus = 5 },
    no_collection = true,
    atlas = "wooden",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.bonus } }
    end,
    in_pool = function()
        return false
    end
}