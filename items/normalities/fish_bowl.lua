BundlesOfFun.Joker {
    key = "fish_bowl",
    name = "Fish in a Bowl",
    bundle = { "normalities", { "fish" } },
    config = {
        extra = {
            sell_cost_mod = 1,
            odds = 3
        }
    },
    pos = { x = 1, y = 6 },
    pixel_size = { h = 69 },
    attributes = { "scaling", "generation", "chance", "fish" },
    cost = 5,
    rarity = 2,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_bof_fish_bowl")
		return {
			vars = {
                card.ability.extra.sell_cost_mod,
				numerator,
                denominator
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, "j_bof_fish_bowl", 1, card.ability.extra.odds) then
                G.GAME.bof_fish_bowl_sell_cost = card.sell_cost
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        play_sound("tarot1")
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        card:flip()
                        play_sound("card1", 1)
                        card:juice_up(0.3, 0.3)
                        return true
                    end
                }))
                delay(0.2)
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        card:set_ability("j_bof_dead_fish_bowl")
                        return true
                    end
                }))
                card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_bof_expired") })
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        card:flip()
                        play_sound("tarot2", 1, 0.6)
                        card:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            else
                card.sell_cost = card.sell_cost + card.ability.extra.sell_cost_mod
                return {
                    message = "Value Up!",
                    colour = G.C.MONEY
                }
            end
        end
    end
}