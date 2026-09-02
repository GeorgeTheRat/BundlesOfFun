BundlesOfFun.Joker {
    key = "leek",
    name = "Leek",
    bundle = "appetizers",
    config = {
        extra = {
            prob = 3.9,
            prob_mod = 0.1
        }
    },
    pos = { x = 3, y = 0 },
    attributes = { "mod_chance", "scaling", "passive", "food" },
    cost = 4,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.prob,
                card.ability.extra.prob_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator + card.ability.extra.prob
            }
        end
        if context.pseudorandom_result and context.result and not card.ability.extra.eaten then
            local last_use = card.ability.extra.prob <= 0.1
            if not last_use then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "prob",
                    scalar_value = "prob_mod",
                    operation = "-",
                    no_message = true
                })
                if card.ability.extra.prob <= 0.1 then
                    card.ability.extra.prob = 0.1
                end
            else
                card.ability.extra.eaten = true
                SMODS.destroy_cards(card, { pinch_anim = true })
                return {
                    message = localize("k_eaten_ex")
                }
            end
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            reminder_text = {
                { text = "(" },
                { ref_table = "card.ability.extra", ref_value = "prob" },
                { text = "/" },
                { ref_table = "card.joker_display_values", ref_value = "start_count" },
                { text = ")" },
            },
            reminder_text_config = { scale = 0.35 },
            calc_function = function(card)
                card.joker_display_values.start_count = card.joker_display_values.start_count or card.ability.extra.prob
            end,
            style_function = function(card, text, reminder_text, extra)
                local children = reminder_text and reminder_text.children
                if not children then
                    return
                end
                local colour = (math.floor(card.ability.extra.prob * 10) == 1) and G.C.RED or G.C.UI.TEXT_INACTIVE
                for i = 2, 4 do
                    local child = children[i]
                    if child then child.config.colour = colour end
                end
            end
        }
    end
}