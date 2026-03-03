SMODS.Joker({
	key = "j_hotboxer",
	name = "Hotboxer",
	config = {
		extra = {},
	},
	pos = { x = 0, y = 0 },
	rarity = 3,
	order = 27,
	blueprint_compat = true,
	atlas = "placeholder",
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.pre_discard and #context.full_hand == 1 and G.GAME.current_round.discards_left == 1 then
			local a = pseudorandom_element({"Copy", "Destroy" }, pseudoseed("yess"))
			if a == "Copy" then
				local ccard = copy_card(context.full_hand[1])
				G.deck.config.card_limit = G.deck.config.card_limit + 1
				table.insert(G.playing_cards, ccard)
				ccard:add_to_deck()
				G.hand:emplace(ccard)
				ccard.states.visible = nil
				G.E_MANAGER:add_event(Event({
					func = function()
						ccard:start_materialize()
						return true
					end,
				}))
				return {
					message = localize("k_copied_ex"),
				}
			else
                SMODS.destroy_cards(context.full_hand[1])
                return{
                    message = localize("k_bof_destroyed")
                }
            end
		end
	end,
})
