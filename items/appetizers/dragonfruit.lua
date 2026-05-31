SMODS.Joker {
    key = "a_dragonfruit",
    name = "Dragonfruit",
    config = { extra = { nommed = false } },
    pos = { x = 5, y = 0 },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.before then
            card:juice_up(0.3, 0.5)
            for i, v in ipairs(context.full_hand) do
				local new_card = copy_card(context.full_hand[i])
				G.deck.config.card_limit = G.deck.config.card_limit + #context.full_hand
				table.insert(G.playing_cards, new_card)
				new_card:add_to_deck()
				G.deck:emplace(new_card)
            end
            card.ability.extra.nommed = true
            return {
                message = localize("k_copied_ex"),
            }
        end

        if context.discard and not context.blueprint then
            card.ability.extra.nommed = true
            return {
                remove = true
            }
        end

        if (context.drawing_cards or context.after) and card.ability.extra.nommed then
            SMODS.destroy_cards(card, nil, true, true)
            return {
                message = localize("k_eaten_ex")
            }
        end
    end
}