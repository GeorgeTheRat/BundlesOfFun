BundlesOfFun.Back {
	key = "wooden",
    name = "Wooden Deck",
    bundle = "flats",
    config = {
        remove_aces = true,
        extra_cards = { 5, 4, 3, 2 }
    },
	atlas = "deck",
	pos = { x = 2, y = 0 },
    attributes = { "rank", "ace", "full_deck", "enhancements", "modify_card" },
    unlocked = false,
    apply = function()
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
        return args.b_bof_wooden
    end
}

SMODS.Enhancement {
    key = "wooden",
    name = "Wooden Card",
    config = { bonus = 5 },
    attributes = { "chips" },
    no_collection = true,
    atlas = "wooden",
    loc_vars = function(self, info_queue, card)
        local ability = card and card.ability or self.config
        return { vars = { (ability.bonus or self.config.bonus or 0) + (ability.perma_bonus or 0) } }
    end,
    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        local merged_vars = copy_table(specific_vars or {})
        merged_vars.bonus_chips = nil
        SMODS.Enhancement.generate_ui(self, info_queue, card, desc_nodes, merged_vars, full_UI_table)
    end,
    in_pool = function()
        return false
    end
}