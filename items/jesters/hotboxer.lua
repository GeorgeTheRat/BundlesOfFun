BundlesOfFun.Joker({
	key = "hotboxer",
	name = "Hotboxer",
	bundle = "jesters",
	config = {
		extra = {
			shop_slots = 1,
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
				card.ability.extra.shop_slots,
				card.ability.extra.sell_cost_mod
			}
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.shop.joker_max = G.GAME.shop.joker_max + card.ability.extra.shop_slots
	end,
	calculate = function(self, card, context)
		if context.buying_card and context.card.ability.set == "Tarot" then
			card.sell_cost = card.sell_cost - card.ability.extra.sell_cost_mod
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.shop.joker_max = G.GAME.shop.joker_max - card.ability.extra.shop_slots
	end
})
