BundlesOfFun.Joker {
    key = "beltrame",
    name = "Beltrame",
    bundle = "fables",
    pos = { x = 9, y = 7 },
    soul_pos = { x = 9, y = 8 },
    config = {
        extra = {
            max = 10,
            count = 0
        }
    },
    attributes = { "generation", "tag" },
    cost = 20,
    rarity = 4,
    unlocked = false,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Tag", key = "tag_polychrome" }
        info_queue[#info_queue + 1] = G.P_TAGS.tag_garbage
        info_queue[#info_queue + 1] = G.P_TAGS.tag_orbital
        info_queue[#info_queue + 1] = { set = "Tag", key = "tag_standard" }
        return { vars = { card.ability.extra.max } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and context.end_of_round and card.ability.extra.count < card.ability.extra.max then
            local other_card = context.other_card
            if other_card:is_suit("Spades") then
                G.E_MANAGER:add_event(Event({ 
                    func = function()
                        add_tag(Tag("tag_polychrome"))
                        return true 
                    end 
                }))
            end
            if other_card:is_suit("Hearts") then
                G.E_MANAGER:add_event(Event({ 
                    func = function()
                        add_tag(Tag("tag_garbage"))
                        return true 
                    end 
                }))
            end
            if other_card:is_suit("Clubs") then
                G.E_MANAGER:add_event(Event({ 
                    func = function()
                        local _poker_hands = {}
                        for k, v in pairs(G.GAME.hands) do
                            if v.visible then
                                _poker_hands[#_poker_hands + 1] = k
                            end
                        end
                        Tag("tag_orbital").ability.orbital_hand = pseudorandom_element(_poker_hands, "fpr_sugar_free_cola")
                        Tag("tag_orbital"):set_ability()
                        add_tag(Tag("tag_orbital"))
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
            card.ability.extra.count = card.ability.extra.count + 1
        end
        if context.blind_defeated then
            card.ability.extra.count = 0
        end
    end
}