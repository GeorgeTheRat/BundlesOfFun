BundlesOfFun.Joker {
    key = "milko",
    name = "Milko",
    bundle = "appetizers",
    config = {
        extra = {
            discards = 3,
            discards_mod = 2,
            discards_req = 2
        }
    },
    -- pos = { x = 13, y = 0 },
    attributes = { "discard", "scaling", "food" },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.discards,
                card.ability.extra.discards_mod,
                card.ability.extra.discards_req
            }
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
        ease_discard(card.ability.extra.discards)
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint and not context.individual then
            if (G.GAME.round_resets.discards - G.GAME.current_round.discards_used) < card.ability.extra.discards_req then
                if card.ability.extra.discards <= card.ability.extra.discards_mod then
                    SMODS.destroy_cards(card, { pinch_anim = true })
                    return {
                        message = localize("k_eaten_ex")
                    }
                else
                    local discards_before = card.ability.extra.discards
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "discards",
                        scalar_value = "discards_mod",
                        operation = "-",
                        no_message = true
                    })
                    G.GAME.round_resets.discards = G.GAME.round_resets.discards - (discards_before - card.ability.extra.discards)
                    ease_discard(-(discards_before - card.ability.extra.discards))
                    return {
                        message = localize("k_sipped_ex"),
                        colour = G.C.RED
                    }
                end
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
        ease_discard(-card.ability.extra.discards)
    end,
    joker_display_def = function(JokerDisplay)
        return {
            reminder_text = {
                { text = "(" },
                { ref_table = "card.ability.extra", ref_value = "discards" },
                { text = "/" },
                { ref_table = "card.joker_display_values", ref_value = "start_count_milko" },
                { text = ")" },
            },
            calc_function = function(card)
                card.joker_display_values.start_count_milko = card.joker_display_values.start_count_milko or card.ability.extra.discards
            end,
            style_function = function(card, text, reminder_text, extra)
                local children = reminder_text and reminder_text.children
                if not children then
                    return
                end
                local colour = (card.ability.extra.discards == 1) and G.C.RED or G.C.UI.TEXT_INACTIVE
                for i = 2, 4 do 
                    local child = children[i]
                    if child then child.config.colour = colour end
                end
            end
        }
    end
}
