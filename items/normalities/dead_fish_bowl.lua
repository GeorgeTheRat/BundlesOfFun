BundlesOfFun.Joker {
    key = "dead_fish_bowl",
    name = "Dead Fish in a Bowl",
    bundle = { "normalities", { "fish" } },
    config = {
        extra = {
            sell_cost_mod = 1,
            destroy = 0,
            gonna_go = false
        }
    },
    pos = { x = 4, y = 6 },
    pixel_size = { h = 69 },
    attributes = { "scaling", "generation", "fish" },
    cost = 1,
    rarity = 2,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_bof_gold_s
		return {
			vars = {
                card.ability.extra.sell_cost_mod,
                card.ability.extra.destroy
            }
        }
    end,
    add_to_deck = function(self, card, context)
        card.sell_cost = G.GAME.bof_fish_bowl_sell_cost or card.sell_cost
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint then
            if #G.consumeables.cards < G.consumeables.config.card_limit + (G.GAME.bof_fish_extra_consumable_slots or 0) + 1 then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        play_sound("timpani")
                        SMODS.add_card({
                            key = "c_bof_gold_s",
                            area = G.consumeables,
                            key_append = "bof_dead_fish_bowl"
                        })
                        return true
                    end
                }))
                card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_plus_fish"), colour = G.C.SET.Fish })
            end
            card.sell_cost = card.sell_cost - card.ability.extra.sell_cost_mod
            return {
                message = "Value Down!",
                colour = G.C.RED
            }
        end
    end,
    update = function(self, card, dt)
        if card.sell_cost <= card.ability.extra.destroy and not card.ability.extra.gonna_go then
            card.ability.extra.gonna_go = true
            SMODS.destroy_cards(card, { pinch_anim = true })
            card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_bof_expired") })
        end
    end,
    remove_from_deck = function(self, card, context)
        G.GAME.bof_fish_bowl_sell_cost = nil
    end,
    in_pool = function()
        return false
    end
}
