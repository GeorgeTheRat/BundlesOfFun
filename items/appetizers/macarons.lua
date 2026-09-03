BundlesOfFun.Joker {
    key = "macarons",
    name = "Macarons",
    bundle = "appetizers",
    config = {
        extra = {
            balance = 60,
            balance_mod_min = 6,
            balance_mod_max = 12
        }
    },
    pos = { x = 5, y = 0 },
    attributes = { "balance", "scaling", "food" },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.balance,
                card.ability.extra.balance_mod_min,
                card.ability.extra.balance_mod_max
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                bof_balance_percent = card.ability.extra.balance
            }
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
            local balance_mod = math.random(card.ability.extra.balance_mod_min, card.ability.extra.balance_mod_max)
            if card.ability.extra.balance >= balance_mod then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "balance",
                    scalar_table = { balance_mod = balance_mod },
                    scalar_value = "balance_mod",
                    operation = "-",
                    scaling_message = {
                        message = localize{ type = "variable", key = "a_bof_balance_minus", vars = { balance_mod } },
                        colour = G.C.PLASMA
                    }
                })
            else
                SMODS.destroy_cards(card, { pinch_anim = true })
                return {
                    message = localize("k_eaten_ex")
                }
            end
        end
    end,
    in_pool = function(self, args)
        return G.GAME and G.GAME.selected_back.effect.center.key ~= "b_plasma"
    end,
    joker_display_def = function(JokerDisplay)
        return {
            reminder_text = {
                { text = "(" },
                { ref_table = "card.ability.extra", ref_value = "balance" },
                { text = "%/" },
                { ref_table = "card.joker_display_values", ref_value = "start_count" },
                { text = "%" },
                { text = ")" }
            },
            reminder_text_config = { scale = 0.35 },
            calc_function = function(card)
                card.joker_display_values.start_count = card.joker_display_values.start_count or card.ability.extra.balance
            end,
            style_function = function(card, text, reminder_text, extra)
                local children = reminder_text and reminder_text.children
                if not children then
                    return
                end
                local colour = (card.ability.extra.balance == 1) and G.C.RED or G.C.UI.TEXT_INACTIVE
                for i = 2, 5 do 
                    local child = children[i]
                    if child then child.config.colour = colour end
                end
            end
        }
    end
}