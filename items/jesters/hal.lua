BundlesOfFun.Joker {
    key = "hal",
    name = "Hatty Hal",
    bundle = "jesters",
    config = {
        extra = {
            chips_mod = 3,
            chips_mod_mod = 1,
            chips = 0
        }
    },
    pos = { x = 0, y = 2 },
    attributes = { "chips", "scaling", "scale_scaling" },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    perishable_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips_mod,
                card.ability.extra.chips_mod_mod,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.playing_card_added and not context.blueprint then
            for _, c in ipairs(context.cards) do
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "chips_mod",
                    no_message = true
                })
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips_mod",
                    scalar_value = "chips_mod_mod",
                    no_message = true
                })
                if card.children.center and card.children.center.sprite_pos and card.children.center.sprite_pos.x ~= 9 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if card.children.center.atlas == G.ASSET_ATLAS["bof_joker"] then
                                card.children.center.atlas = G.ASSET_ATLAS["bof_hal"]
                                card.children.center:set_sprite_pos({ x = 0, y = 0 })
                            else
                                card.children.center:set_sprite_pos({ x = card.children.center.sprite_pos.x + 1, y = 0 })
                            end
                            return true
                        end
                    }))
                end
            end
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.BLUE
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "chips" }
            },
            text_config = { colour = G.C.CHIPS },
        }
    end
}