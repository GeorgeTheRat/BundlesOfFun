BundlesOfFun.Joker {
    key = "fancy",
    name = "Fancy Pants",
    bundle = "jesters",
    pos = { x = 6, y = 2 },
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
            -- on the fourth day of christmas, my true love gave to me
            local four_calling_birds = context.blueprint_card or card
            -- three_french_hens
            -- two_turtle_doves
            -- and a_partridge_in_a_pear_tree
            G.E_MANAGER:add_event(Event({
                func = function()
                    if pseudorandom("j_bof_frank") < 0.5 then
                        add_tag(Tag("tag_handy"))
                    else
                        add_tag(Tag("tag_garbage"))
                    end
                    four_calling_birds:juice_up(0.3, 0.5)
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
                                    four_calling_birds:juice_up(0.3, 0.5)
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
    end,
    joker_display_def = function(JokerDisplay)
        return {
            reminder_text = {
                { text = "(", colour = G.C.UI.TEXT_INACTIVE },
                { ref_table = "card.joker_display_values", ref_value = "active_text" },
                { text = ")", colour = G.C.UI.TEXT_INACTIVE },
            },
            calc_function = function(card)
                local active = G.STATE == G.STATES.BLIND_SELECT and G.STATE_COMPLETE and G.GAME.blind and G.GAME.blind:get_type() == "Small"
                card.joker_display_values.active = active
                card.joker_display_values.active_text = localize(active and "jdis_active" or "jdis_inactive")
            end,
            style_function = function(card, text, reminder_text, extra)
                if reminder_text and reminder_text.children and reminder_text.children[2] then
                    reminder_text.children[2].config.colour = card.joker_display_values.active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
                end
            end
        }
    end
}