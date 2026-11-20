BundlesOfFun.Joker {
    key = "dead_fish_bowl",
    name = "Dead Fish in a Bowl",
    bundle = { "normalities", { "minnows" } },
    config = {
        extra = {
            sell_cost_mod = 1,
            destroy = 0,
            gonna_go = false
        }
    },
    pos = { x = 12, y = 5 },
    pixel_size = { h = 69 },
    attributes = { "scaling", "generation", "fish" },
    cost = 1,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
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
    add_to_deck = function(self, card)
        card.sell_cost = G.GAME.bof_fish_bowl_sell_cost or card.sell_cost
        card.ability.extra_value = (G.GAME.bof_fish_bowl_extra_value or card.ability.extra_value) + 1
        card:set_cost()
        G.GAME.bof_fish_bowl_sell_cost = nil
        G.GAME.bof_fish_bowl_extra_value = nil
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
                SMODS.calculate_effect({ message = localize("k_plus_fish"), colour = G.C.SET.Fish }, card)
            end
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "extra_value",
                scalar_table = card.ability.extra,
                scalar_value = "sell_cost_mod",
                operation = "-",
                scaling_message = {
                    message = localize("k_val_down_ex"),
                    colour = G.C.RED
                }
            })
            card:set_cost()
        end
    end,
    update = function(self, card)
        if card.sell_cost <= card.ability.extra.destroy and not card.ability.extra.gonna_go and G.STATE ~= G.STATES.GAME_OVER then
            card.ability.extra.gonna_go = true
            SMODS.destroy_cards(card, { pinch_anim = true })
            SMODS.calculate_effect({ message = localize("k_expired_ex") }, card)
        end
    end,
    in_pool = function()
        return false
    end
}
