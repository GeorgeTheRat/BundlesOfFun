BundlesOfFun.Consumable {
    key = "octopus_l",
    name = "Octopus Legendary",
    bundle = "fish",
    set = "Fish",
    soul_set = "Fish",
    pools = { ["fish_l"] = true },
    pos = { x = 7, y = 2 },
    config = { card_limit = 1 },
    cost = 20,
    unlocked = false,
    hidden = true,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.card_limit } }
    end,
    trigger = function(self, fish_key)
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit + (G.GAME.bof_fish_extra_consumable_slots or 0) + 1 then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    local base_key = fish_key:sub(1, -3)
                    SMODS.add_card {
                        set = "Fish",
                        key = base_key .. "_l",
                        key_append = "bof_octopus"
                    }
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            card_eval_status_text(self, "extra", nil, nil, nil, { message = localize("k_plus_fish"), colour = G.C.SET.Fish })
            SMODS.destroy_cards(self, { pinch_anim = true })
            return {
                message = localize("k_bof_expired")
            }
        end
    end,
    set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize("k_fish_q"), get_type_colour(card.config.center or card.config, card), G.C.FISH, 1.2)
    end
}
