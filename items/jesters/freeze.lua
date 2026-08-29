BundlesOfFun.Joker {
    key = "freeze",
    name = "Brain Freeze",
    bundle = "jesters",
    config = {
        extra = {
            xmult_mod = 0.5,
            active = true,
            xmult = 1
        }
    },
    pos = { x = 4, y = 5 },
    attributes = { "xmult", "hand_type", "planet" },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    perishable_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            key = BundlesOfFun.config.evil_dih and "j_bof_brian" or "j_bof_freeze",
            vars = {
                card.ability.extra.xmult_mod,
                card.ability.extra.active and localize("k_active_ex") or localize("k_inactive_el"),
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_card and context.card.ability.set == "Planet" and not context.blueprint then
            if card.ability.extra.active then
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
                card.ability.extra.active = false
            else
                card.ability.extra.active = true
                return {
                    message = localize("k_active_ex")
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}