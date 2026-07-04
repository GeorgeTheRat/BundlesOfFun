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
	cost = 8,
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
			local how_many_pickles = context.blueprint_card or card
			how_many_pickles.sell_cost = how_many_pickles.sell_cost - card.ability.extra.sell_cost_mod
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