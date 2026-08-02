BundlesOfFun.Joker {
    key = "freeze",
    name = "Brain Freeze",
    bundle = "jesters",
    config = {
        extra = {
            xmult_mod = 0.25,
            xmult = 1
        }
    },
    pos = { x = 4, y = 5 },
    attributes = { "xmult", "hand_type", "planet" },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    perishable_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_mod,
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_card and context.card.ability.set == "Planet" and not context.blueprint then
            local available_hands = {}
            for hand, value in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(hand) and G.GAME.hands[hand].level > 1 then
                    table.insert(available_hands, hand)
                end
            end
            if #available_hands > 0 then
                local selected_hand = pseudorandom_element(available_hands, pseudoseed("bof_freeze"))
                SMODS.upgrade_poker_hands({
                    hands = selected_hand,
                    level_up = -1,
                    from = card
                })
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult",
                    scalar_value = "xmult_mod",
                    message_colour = G.C.MULT
                })
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}