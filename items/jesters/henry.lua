BundlesOfFun.Joker {
    key = "henry",
    name = "Handy Henry",
    bundle = "jesters",
    config = { extra = { hand_bonus = 2 } },
    pos = { x = 1, y = 1 },
    attributes = { "passive", "economy", "hands" },
    cost = 5,
    rarity = 2,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hand_bonus } }
    end,
    add_to_deck = function(self, card)
        G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 1) + card.ability.extra.hand_bonus
    end,
    remove_from_deck = function(self, card)
        G.GAME.modifiers.money_per_hand = math.max(1, (G.GAME.modifiers.money_per_hand or 1) - card.ability.extra.hand_bonus)
    end,
    joker_display_def = function()
        return {
            text = {
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "dollars",
                    signed = "$",
                    retrigger_type = "*",
                    colour = G.C.MONEY
                }
            },
            reminder_text = {
                { ref_table = "card.joker_display_values", ref_value = "localized_text" },
            },
            calc_function = function(card)
                card.joker_display_values.dollars = card.ability.extra.hand_bonus * (BOF.nc(G.GAME.current_round, "hands_left") or 0)
                card.joker_display_values.localized_text = "(" .. localize("k_round") .. ")"
            end
        }
    end
}