BundlesOfFun.Joker {
    key = "blueberries",
    name = "Blueberries",
    bundle = "appetizers",
    config = {
        extra = {
            perma_bonus = 6,
            perma_bonus_mod = 1
        }
    },
    pos = { x = 1, y = 0 },
    attributes = { "chips", "scaling", "modify_card", "perma_bonus", "food" },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.perma_bonus,
                card.ability.extra.perma_bonus_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.perma_bonus
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.CHIPS
            }
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
            if card.ability.extra.perma_bonus <= card.ability.extra.perma_bonus_mod then
                SMODS.destroy_cards(card, { pinch_anim = true })
                return {
                    message = localize("k_eaten_ex")
                }
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "perma_bonus",
                    scalar_value = "perma_bonus_mod",
                    operation = "-",
                    scaling_message = {
                        message = localize{ type = "variable", key = "a_chips_minus", vars = { card.ability.extra.perma_bonus_mod } },
                        colour = G.C.CHIPS
                    }
                })
            end
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            reminder_text = {
                { text = "(" },
                { ref_table = "card.ability.extra", ref_value = "perma_bonus" },
                { text = "/" },
                { ref_table = "card.joker_display_values", ref_value = "start_count" },
                { text = ")" },
            },
            reminder_text_config = { scale = 0.35 },
            calc_function = function(card)
                card.joker_display_values.start_count = card.joker_display_values.start_count or card.ability.extra.perma_bonus
            end,
            style_function = function(card, text, reminder_text, extra)
                local children = reminder_text and reminder_text.children
                if not children then
                    return
                end
                local colour = (card.ability.extra.perma_bonus == 1) and G.C.RED or G.C.UI.TEXT_INACTIVE
                for i = 2, 4 do 
                    local child = children[i]
                    if child then child.config.colour = colour end
                end
            end
        }
    end
}