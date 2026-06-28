BundlesOfFun.Joker {
    key = "shennong",
    name = "Shennong",
    bundle = "fables",
    pos = { x = 5, y = 4 },
    soul_pos = { x = 5, y = 5 },
    attributes = { "mod_chance", "enhancements", "modify_card", "boss_blind" },
    cost = 20,
    rarity = 4,
    unlocked = false,
    blueprint_compat = false,
    atlas = "joker",
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
                            if G.deck and G.deck.cards and #G.deck.cards > 0 then
                                G.deck.cards[1]:set_ability(G.P_CENTERS.m_lucky)
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
    end
}