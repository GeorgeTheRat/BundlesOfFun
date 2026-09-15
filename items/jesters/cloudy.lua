BundlesOfFun.Joker {
    key = "cloudy",
    name = "Cloudy Joker",
    bundle = "jesters",
    no_mod_badges = BundlesOfFun.config.evil_dih and true or false,
    rarity = 1,
    cost = 4,
    pos = { x = 4, y = 4 },
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local nine_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:get_id() == 9 then nine_tally = nine_tally + 1 end
            end
        end
        return {
            key = BundlesOfFun.config.evil_dih and "j_bof_cloud_9" or "j_bof_cloudy",
            vars = { nine_tally }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = G.GAME.hands[context.scoring_name].chips
            }
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        G.E_MANAGER:add_event(Event({
            func = function()
                if self.discovered and BundlesOfFun.config.evil_dih then
                    card.children.center.atlas = G.ASSET_ATLAS["bof_evil_dih"]
                end
                return true
            end
        }))
	end,
    set_card_type_badge = function(self, card, badges)
        if BundlesOfFun.config.evil_dih then
            badges[#badges + 1] = create_badge(localize("bof_green_common"), G.C.GREEN_COMMON, G.C.WHITE, 1.2)
        else
            badges[#badges + 1] = create_badge(localize("k_common"), G.C.RARITY[1], G.C.WHITE, 1.2)
        end
    end
}