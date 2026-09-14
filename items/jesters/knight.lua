BundlesOfFun.Joker {
    key = "knight",
    name = "Knight",
    bundle = "jesters",
    rarity = 2,
    cost = 6,
    pos = { x = 7, y = 4 },
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.setting_ability and context.other_card and context.new and context.new ~= "c_base" then
            if not context.other_card.bof_knight_enhancing then
                if not G.GAME.bof_knight_trigger_sequence then
                    G.GAME.bof_knight_trigger_sequence = {}
                end
                if not G.GAME.bof_knight_trigger_sequence[context.other_card] then
                    G.GAME.bof_knight_trigger_sequence = {}
                end
                G.GAME.bof_knight_trigger_sequence[context.other_card] = true
                local targets = {}
                for _, hand_card in ipairs(G.hand.cards) do
                    if hand_card ~= context.other_card and not hand_card.debuff
                        and not hand_card.bof_knight_enhancing
                        and not G.GAME.bof_knight_trigger_sequence[hand_card] then
                        targets[#targets + 1] = hand_card
                    end
                end
                if #targets > 0 then
                    local target = pseudorandom_element(targets, pseudoseed("bof_knight"))
                    local enhancements = {}
                    for _, center in pairs(G.P_CENTERS) do
                        if center.set == "Enhanced" then
                            enhancements[#enhancements + 1] = center
                        end
                    end
                    local enhancement = pseudorandom_element(enhancements, pseudoseed("bof_knight"))
                    target.bof_knight_enhancing = true
                    G.GAME.bof_knight_trigger_sequence[target] = true
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.15,
                        func = function()
                            target:flip()
                            play_sound("card1", 1.15)
                            target:juice_up(0.3, 0.3)
                            return true
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.1,
                        func = function()
                            target:set_ability(enhancement)
                            return true
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.15,
                        func = function()
                            target:flip()
                            play_sound("tarot2", 0.85, 0.6)
                            target:juice_up(0.3, 0.3)
                            target.bof_knight_enhancing = nil
                            card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                end
            end
        end
    end
}