BundlesOfFun.Joker {
	key = "hotboxer",
	name = "Hotboxer",
	bundle = "jesters",
	config = {
		extra = {
			shop_size = 1,
			sell_cost_mod = 1
		}
	},
	pos = { x = 9, y = 2 },
	attributes = { "generation", "passive", "tarot" },
	cost = 7,
	rarity = 2,
	blueprint_compat = false,
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
			card.sell_cost = card.sell_cost - card.ability.extra.sell_cost_mod
			return {
				message = localize("k_val_down_ex"),
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
}
