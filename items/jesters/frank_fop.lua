SMODS.Joker {
    key = "j_frank_fop",
    name = "Frank Fop",
    pos = { x = 1, y = 3 },
    cost = 3,
    rarity = 1,
    order = 32,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS.tag_double
    end,
    calculate = function(self,card,context)
        if context.bof_pre_skip and (not G.HUD_tags or G.HUD_tags and #G.HUD_tags == 0) then
            G.E_MANAGER:add_event(Event({
				func = function()
					add_tag(Tag("tag_double"))
					play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
					play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
					return true
				end,
			}))
        end
    end
}