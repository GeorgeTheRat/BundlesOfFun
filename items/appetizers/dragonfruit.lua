SMODS.Joker {
    key = "a_dragonfruit",
    name = "Dragonfruit",
    config = {
        extra = {
            nommed = false
        }
    },
    pos = { x = 5, y = 0 },
    cost = 1,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            for i,v in ipairs(context.full_hand) do
                local newcard = copy_card(v,nil, nil, true)
                newcard:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, newcard)
                G.hand:emplace(newcard)
                newcard.states.visible = nil

                G.E_MANAGER:add_event(Event({
                    func = function()
                        newcard:start_materialize()
                        return true
                    end
                }))
                SMODS.calculate_effect({message = localize("k_copied_ex")}, card)
            end

            card.ability.extra.nommed = true
            return nil, true
        end

        if context.discard then
            card.ability.extra.nommed = true
            return {
                remove = true
            }
        end

        if (context.drawing_cards or context.after) and card.ability.extra.nommed then
            SMODS.calculate_effect({message = localize("k_eaten_ex")}, card)
            SMODS.destroy_cards(card, true, true, true)
        end
    end
}