BundlesOfFun.Consumable {
    key = "octopus_l",
    name = "Octopus Legendary",
    bundle = "fish",
    set = "Fish",
    soul_set = "Fish",
    pools = { ["fish_l"] = true },
    pos = { x = 6, y = 2 },
    config = { card_limit = 1 },
    cost = 20,
    unlocked = false,
    hidden = true,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.card_limit } }
    end,
    trigger = function(self, fish_key)
        if #G.consumeables.cards < G.consumeables.config.card_limit then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local base_key = fish_key:sub(1, -3)
                    SMODS.add_card {
                        set = "Fish",
                        key = base_key .. "_l",
                        key_append = "bof_octopus"
                    }
                    return true
                end
            }))
            card_eval_status_text(self, "extra", nil, nil, nil, { message = localize("k_plus_fish"), colour = G.C.SET.Fish })
            SMODS.destroy_cards(self, { pinch_anim = true })
            return {
                message = localize("k_bof_expired")
            }
        end
    end
}