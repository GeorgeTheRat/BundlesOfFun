SMODS.Joker({
	key = "j_hotboxer",
	name = "Hotboxer",
	config = {
		extra = {
			max_highlighted = 1,
		},
	},
	pos = { x = 0, y = 3 },
	cost = 8,
	rarity = 2,
	blueprint_compat = true,
	atlas = "joker",
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.max_highlighted },
		}
	end,
	calculate = function(self, card, context)
		if context.pre_discard and #context.full_hand == card.ability.extra.max_highlighted and G.GAME.current_round.discards_left == 1 then
			if pseudorandom_element({"copy", "destroy" }, pseudoseed("j_bof_j_hotboxer")) == "copy" then
				local new_card = copy_card(context.full_hand[1])
				G.deck.config.card_limit = G.deck.config.card_limit + 1
				table.insert(G.playing_cards, new_card)
				new_card:add_to_deck()
				G.deck:emplace(new_card)
				return {
					message = localize("k_copied_ex"),
				}
			else
                SMODS.destroy_cards(context.full_hand[1])
                return {
                    message = localize("k_bof_destroyed")
                }
            end
		end
	end,
})
