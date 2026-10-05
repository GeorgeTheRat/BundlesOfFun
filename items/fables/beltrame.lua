BundlesOfFun.Joker {
    key = "beltrame",
    name = "Beltrame",
    bundle = "fables",
    pos = { x = 9, y = 6 },
    soul_pos = { x = 9, y = 7 },
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
            local function juice()
                card:juice_up(0.3, 0.5)
                other_card:juice_up(0.3, 0.5)
                play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
                play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
            end
            if other_card:is_suit("Spades") then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        add_tag(Tag("tag_polychrome"))
                        juice()
                        return true
                    end
                }))
                card.ability.extra.count = card.ability.extra.count + 1
                delay(0.2)
            end
            if other_card:is_suit("Hearts") and card.ability.extra.count < card.ability.extra.max then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        add_tag(Tag("tag_garbage"))
                        juice()
                        return true
                    end
                }))
                card.ability.extra.count = card.ability.extra.count + 1
                delay(0.2)
            end
            if other_card:is_suit("Clubs") and card.ability.extra.count < card.ability.extra.max then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local _poker_hands = {}
                        for k, v in pairs(G.GAME.hands) do
                            if v.visible then
                                _poker_hands[#_poker_hands + 1] = k
                            end
                        end
                        Tag("tag_orbital").ability.orbital_hand = pseudorandom_element(_poker_hands, "bof_beltrame")
                        Tag("tag_orbital"):set_ability()
                        add_tag(Tag("tag_orbital"))
                        juice()
                        return true
                    end
                }))
                card.ability.extra.count = card.ability.extra.count + 1
                delay(0.2)
            end
            if other_card:is_suit("Diamonds") and card.ability.extra.count < card.ability.extra.max then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        add_tag(Tag("tag_standard"))
                        juice()
                        return true
                    end
                }))
                card.ability.extra.count = card.ability.extra.count + 1
                delay(0.2)
            end
            return nil, true
        end
        if context.blind_defeated then
            card.ability.extra.count = 0
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { ref_table = "card.joker_display_values", ref_value = "spades_count" },
                { ref_table = "card.joker_display_values", ref_value = "hearts_count" },
                { ref_table = "card.joker_display_values", ref_value = "clubs_count" },
                { ref_table = "card.joker_display_values", ref_value = "diamonds_count" }
            },
            calc_function = function(card)
                local playing_hand = next(G.play.cards)
                local spades, hearts, clubs, diamonds = 0, 0, 0, 0
                if BOF.nc(G.hand, "cards") then
                    for _, c in ipairs(G.hand.cards) do
                        if playing_hand or not c.highlighted then
                            if c:is_suit("Spades") then spades = spades + 1 end
                            if c:is_suit("Hearts") then hearts = hearts + 1 end
                            if c:is_suit("Clubs") then clubs = clubs + 1 end
                            if c:is_suit("Diamonds") then diamonds = diamonds + 1 end
                        end
                    end
                end
                card.joker_display_values.spades_count = spades .. " "
                card.joker_display_values.hearts_count = hearts .. " "
                card.joker_display_values.clubs_count = clubs .. " "
                card.joker_display_values.diamonds_count = diamonds
            end,
            style_function = function(card, text, extra)
                if BOF.nc(text, "children") then
                    if text.children[1] then
                        text.children[1].config.colour = lighten(G.C.SUITS["Spades"], 0.35)
                    end
                    if text.children[2] then
                        text.children[2].config.colour = lighten(G.C.SUITS["Hearts"], 0.35)
                    end
                    if text.children[3] then
                        text.children[3].config.colour = lighten(G.C.SUITS["Clubs"], 0.35)
                    end
                    if text.children[4] then
                        text.children[4].config.colour = lighten(G.C.SUITS["Diamonds"], 0.35)
                    end
                end
            end
        }
    end
}