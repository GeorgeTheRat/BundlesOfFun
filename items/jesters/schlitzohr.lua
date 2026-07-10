BundlesOfFun.Joker({
	key = "schlitzohr",
	name = "Schlitzohr",
	bundle = "jesters",
	config = { extra = { cards = 4 } },
	pos = { x = 4, y = 2 },
	attributes = { "full_deck", "modify_card" },
	cost = 5,
	rarity = 2,
	blueprint_compat = true,
	atlas = "joker",
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			local blueprint = context.blueprint
			-- on the fourth day of christmas, my true love gave to me
			local four_calling_birds = context.blueprint_card or card
			-- three_french_hens
			-- two_turtle_doves
			-- and a_partridge_in_a_pear_tree
			G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot1")
				four_calling_birds:juice_up(0.3, 0.5)
				return true
			end
			}))
			for i = 1, card.ability.extra.cards do
				local percent = 1.15 - (i - 0.999) / (card.ability.extra.cards - 0.998) * 0.3
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						play_sound("card1", percent)
						return true
					end
				}))
			end
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.15,
						func = function()
							if G.deck and G.deck.cards then
								local sorted_cards = {}
								for _, c in ipairs(G.deck.cards) do
									table.insert(sorted_cards, c)
								end
								table.sort(sorted_cards, function(a, b) return (a:get_id() or 0) < (b:get_id() or 0) end)
								local target_cards = {}
								local skip_count = blueprint and (blueprint * card.ability.extra.cards) or 0
								for i = 1 + skip_count, math.min(card.ability.extra.cards + skip_count, #sorted_cards) do
									table.insert(target_cards, sorted_cards[i])
								end
								for i, target_card in ipairs(target_cards) do
									G.E_MANAGER:add_event(Event({
										trigger = "after",
										delay = 0.15,
										func = function()
											local _rank = pseudorandom_element(SMODS.Ranks, "random_rank")
											assert(SMODS.change_base(target_card, nil, _rank.key))
											return true
										end
									}))
								end
							end
							return true
						end
					}))
					for i = 1, card.ability.extra.cards do
						local percent = 0.85 + (i - 0.999) / (card.ability.extra.cards - 0.998) * 0.3
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.15,
							func = function()
								play_sound("tarot2", percent, 0.6)
								return true
							end
						}))
					end
					return true
				end
			}))
		end
	end
})