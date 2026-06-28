BundlesOfFun.Joker {
    key = "dragonfruit",
    name = "Dragonfruit",
    bundle = "appetizers",
    config = { extra = { nommed = false } },
    pos = { x = 5, y = 0 },
    attributes = { "generation", "destruction", "food" },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.before then
            card:juice_up(0.3, 0.5)
            for i, v in ipairs(context.full_hand) do
                local new_card = SMODS.copy_card(context.full_hand[i], { area = G.deck })
                new_card:start_materialize()
                SMODS.calculate_context({ playing_card_added = true, cards = { new_card } })
            end
            card.ability.extra.nommed = true
            return {
                message = localize("k_copied_ex"),
                colour = G.C.BLUE
            }
        end
        if context.discard and not context.blueprint then
            card.ability.extra.nommed = true
            return {
                remove = true
            }
        end
        if (context.drawing_cards or context.after) and card.ability.extra.nommed then
            SMODS.destroy_cards(card, { pinch_anim = true })
            return {
                message = localize("k_eaten_ex")
            }
        end
    end
}