BundlesOfFun.Joker {
    key = "gonella",
    name = "Gonella",
    bundle = "fables",
    pos = { x = 5, y = 6 },
    soul_pos = { x = 5, y = 7 },
    attributes = { "mod_chance", "enhancements", "modify_card", "boss_blind" },
    cost = 20,
    rarity = 4,
    unlocked = false,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.15,
                        func = function()
                            if BOF.nc(G.deck, "cards") and #G.deck.cards > 0 then
                                G.deck.cards[1]:set_ability("m_lucky")
                            end
                            return true
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.1,
                        func = function()
                            play_sound("tarot2", 1, 0.6)
                            return true
                        end
                    }))
                    return true
                end
            }))
        end
        if context.fix_probability and G.GAME.blind.boss then
            return {
                numerator = context.denominator
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            reminder_text = {
                { text = "(",                              colour = G.C.UI.TEXT_INACTIVE },
                { ref_table = "card.joker_display_values", ref_value = "active_text" },
                { text = ")",                              colour = G.C.UI.TEXT_INACTIVE },
            },
            calc_function = function(card)
                local boss_active = BOF.nc(G.GAME.blind, "get_type") and (G.GAME.blind:get_type() == "Boss") and BOF.nc(G.GAME.blind, "in_blind")
                card.joker_display_values.active = boss_active
                card.joker_display_values.active_text = localize(boss_active and "jdis_active" or "jdis_inactive")
            end,
            style_function = function(card, text, reminder_text, extra)
                if reminder_text and reminder_text.children and reminder_text.children[2] then
                    reminder_text.children[2].config.colour = card.joker_display_values.active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
                end
            end
        }
    end
}