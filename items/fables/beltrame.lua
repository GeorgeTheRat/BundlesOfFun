BundlesOfFun.Joker {
    key = "beltrame",
    name = "Beltrame",
    bundle = "fables",
    pos = { x = 9, y = 7 },
    soul_pos = { x = 9, y = 8 },
    attributes = { "generation", "tag" },
    cost = 20,
    rarity = 4,
    unlocked = false,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Tag", key = "tag_buffoon" }
        info_queue[#info_queue + 1] = { set = "Tag", key = "tag_charm" }
        info_queue[#info_queue + 1] = { set = "Tag", key = "tag_meteor" }
        info_queue[#info_queue + 1] = { set = "Tag", key = "tag_standard" }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and context.end_of_round then
            local other_card = context.other_card
            if other_card:is_suit("Spades") then
                G.E_MANAGER:add_event(Event({ 
                    func = function()
                        add_tag(Tag("tag_buffoon"))
                        return true 
                    end 
                }))
            end
            if other_card:is_suit("Hearts") then
                G.E_MANAGER:add_event(Event({ 
                    func = function()
                        add_tag(Tag("tag_charm"))
                        return true 
                    end 
                }))
            end
            if other_card:is_suit("Clubs") then
                G.E_MANAGER:add_event(Event({ 
                    func = function()
                        add_tag(Tag("tag_meteor"))
                        return true 
                    end 
                }))
            end
            if other_card:is_suit("Diamonds") then
                G.E_MANAGER:add_event(Event({ 
                    func = function()
                        add_tag(Tag("tag_standard"))
                        return true 
                    end 
                }))
            end
            delay(0.2)
            G.E_MANAGER:add_event(Event({ 
                func = function()
                    card:juice_up(0.3, 0.5)
                    other_card:juice_up(0.3, 0.5)
                    play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
                    play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                    return true 
                end 
            }))
        end
    end
}