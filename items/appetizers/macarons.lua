BundlesOfFun.Joker {
    key = "macarons",
    name = "Macarons",
    bundle = "appetizers",
    config = {
        extra = {
            balance = 100,
            balance_mod = 25
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
                card.ability.extra.balance_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.balance > 0 then
                return {
                    bof_balance_percent = card.ability.extra.balance * 0.01
                }
            end
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
            if card.ability.extra.balance - card.ability.extra.balance_mod > 0 then
                card.ability.extra.balance = card.ability.extra.balance - card.ability.extra.balance_mod
                return {
                    message = localize{ type = "variable", key = "a_bof_balance_minus", vars = { card.ability.extra.balance_mod } },
                    colour = G.C.PLASMA
                }
            else
                SMODS.destroy_cards(card, { pinch_anim = true })
                return {
                    message = localize("k_eaten_ex")
                }
            end
        end
    end,
    in_pool = function(self, args)
        if G.GAME then
            if G.GAME.selected_back.effect.center.key ~= "b_plasma" then
                return true
            end
        end
        return false
    end,
    joker_display_def = function(JokerDisplay)
        return {
            reminder_text = {
                { text = "(" },
                { ref_table = "card.ability.extra", ref_value = "balance" },
                { text = "%/" },
                { ref_table = "card.joker_display_values", ref_value = "start_count" },
                { text = "%)" },
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
                local colour = (card.ability.extra.balance == 25) and G.C.RED or G.C.UI.TEXT_INACTIVE
                for i = 2, 4 do 
                    local child = children[i]
                    if child then child.config.colour = colour end
                end
            end
        }
    end
}