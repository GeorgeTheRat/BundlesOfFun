BundlesOfFun.Joker {
    key = "nerd",
    name = "Nerd",
    bundle = "jesters",
    config = {
        extra = {
            rerolls = 5,
            tally = 1
        }
    },
    pos = { x = 6, y = 3 },
    attributes = { "passive" },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.rerolls,
                card.ability.extra.rerolls - (G.GAME.round_scores.times_rerolled.amt % card.ability.extra.rerolls)
            }
        }
    end,
    calculate = function(self, card, context)
        local go = G.GAME.round_scores.times_rerolled.amt % card.ability.extra.rerolls == 0 and G.GAME.round_scores.times_rerolled.amt ~= 0
        local reset = G.GAME.round_scores.times_rerolled.amt % card.ability.extra.rerolls == card.ability.extra.rerolls - 1
        if context.create_shop_card and go and card.ability.extra.tally == 1 then
            card:juice_up(0.3, 0.5)
            if not next(SMODS.find_card("j_bof_pianoman")) then
                card.ability.extra.tally = 0
                return {
                    shop_create_flags = {
                        key = false,
                        set = "Joker",
                        rarity = "Rare"
                    }
                }
            end
        end
        if context.create_shop_card and reset then
            card.ability.extra.tally = 1
            local eval = function()
                local amt = G.GAME.round_scores.times_rerolled.amt
                return amt ~= 0 and amt % card.ability.extra.rerolls ~= 0
            end
            juice_card_until(card, eval, true)
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "rerolls" },
                { text = "/", colour = G.C.UI.TEXT_INACTIVE },
                { ref_table = "card.ability.extra", ref_value = "rerolls" },
                { text = ")", colour = G.C.UI.TEXT_INACTIVE }
            },
            calc_function = function(card)
                local amt, rerolls = G.GAME.round_scores.times_rerolled.amt, card.ability.extra.rerolls
                local remainder = amt % rerolls
                card.joker_display_values.rerolls = rerolls - remainder
                card.joker_display_values.is_ready = amt ~= 0 and remainder == rerolls - 1
            end,
            style_function = function(card, text, reminder_text, extra)
                local colour = card.joker_display_values.is_ready and G.C.GREEN or G.C.UI.TEXT_INACTIVE
                for i = 2, 4 do
                    local node = BOF.nc(reminder_text, "children", i)
                    if BOF.nc(node, "config") then
                        node.config.colour = colour
                    end
                end
            end
        }
    end
}