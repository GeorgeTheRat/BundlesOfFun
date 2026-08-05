BundlesOfFun.Joker {
    key = "fancy",
    name = "Fancy Pants",
    bundle = "jesters",
    pos = { x = 1, y = 4 },
    attributes = { "generation", "tag" },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_handy
        info_queue[#info_queue + 1] = G.P_TAGS.tag_garbage
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
                    card:juice_up(0.3, 0.5)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            for i = 1, #G.GAME.tags do
                                local tag = G.GAME.tags[i]
                                if tag.key == "tag_handy" or tag.key == "tag_garbage" then
                                    tag:apply_to_run({ type = "immediate" })
                                end
                            end
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    card:juice_up(0.3, 0.5)
                                    return true
                                end
                            }))
                            return true
                        end
                    }))
                    return true
                end
            }))
        end
    end
}