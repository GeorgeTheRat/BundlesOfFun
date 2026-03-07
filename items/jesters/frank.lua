SMODS.Joker {
    key = "j_frank",
    name = "Frank Fop",
    pos = { x = 1, y = 3 },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS.tag_handy
        info_queue[#info_queue+1] = G.P_TAGS.tag_garbage
    end,
    calculate = function(self, card, context)
        if context.setting_blind and context.blind.key == "bl_small" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if pseudorandom("j_bof_frank") < 0.5 then
                        add_tag(Tag("tag_handy"))
                    else
                        add_tag(Tag("tag_garbage"))
                    end
                    card:juice_up(0.4, 0.4)
                    play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
                    play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
        end
    end
}