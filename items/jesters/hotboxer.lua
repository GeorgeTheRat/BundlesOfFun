BundlesOfFun.Joker({
	key = "hotboxer",
	name = "Hotboxer",
	bundle = "jesters",
	config = {
		extra = {
			shop_size = 1,
			sell_cost_mod = 1
		}
	},
	pos = { x = 0, y = 3 },
	attributes = { "generation", "passive", "tarot" },
	cost = 7,
	rarity = 2,
	blueprint_compat = true,
	atlas = "joker",
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.shop_size,
				card.ability.extra.sell_cost_mod
			}
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
            func = function()
                change_shop_size(card.ability.extra.shop_size)
                return true
            end
        }))
	end,
	calculate = function(self, card, context)
		if context.buying_card and context.card.ability.set == "Tarot" then
			-- on the third day day of christmas, my true love gave to me
			local three_french_hens = context.blueprint_card or card
			-- two_turtle_doves
			-- and a_partridge_in_a_pear_tree
			three_french_hens.sell_cost = three_french_hens.sell_cost - card.ability.extra.sell_cost_mod
			return {
				message = "Value Down!",
				colour = G.C.RED
			}
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
            func = function()
                change_shop_size(-card.ability.extra.shop_size)
                return true
            end
        }))
	end
})