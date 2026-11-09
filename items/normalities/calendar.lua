BundlesOfFun.Joker {
    key = "calendar",
    name = "Calendar",
    bundle = "normalities",
    config = {
        extra = {
            shop_size = 2,
            shop_size_mod = 1
        }
    },
    pos = { x = 14, y = 5 },
    pixel_size = { w = 59 },
    attributes = { "passive", "shop" },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.shop_size,
                card.ability.extra.shop_size_mod
            }
        }
    end,
    add_to_deck = function(self, card)
        card.ability.extra.og_shop_size = card.ability.extra.shop_size
        G.E_MANAGER:add_event(Event({
            func = function()
                change_shop_size(card.ability.extra.shop_size)
                return true
            end
        }))
    end,
    calculate = function(self, card, context)
        if context.modify_final_cashout and card.ability.extra.shop_ended then
            change_shop_size(card.ability.extra.shop_size)
            card.ability.extra.shop_ended = nil
        end
        if context.buying_card and card.ability.extra.shop_size > 0 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    change_shop_size(math.min(-card.ability.extra.shop_size_mod, (card.ability.extra.shop_size_mod - card.ability.extra.shop_size) + 1))
                    return true
                end
            }))
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "shop_size",
                scalar_value = "shop_size_mod",
                operation = "-",
                scaling_message = {
                    message = card.ability.extra.shop_size - card.ability.extra.shop_size_mod .. ""
                }
            })
        end
        if context.ending_shop then
            SMODS.reset_card(card, {
                ref_table = card.ability.extra,
                ref_value = "shop_size",
                reset_value = card.ability.extra.og_shop_size,
            })
            card.ability.extra.shop_ended = true
        end
    end,
    remove_from_deck = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                change_shop_size(-card.ability.extra.shop_size)
                return true
            end
        }))
    end,
    joker_display_def = function()
        return {
            text = {
                {
                    ref_table = "card.ability.extra",
                    ref_value = "shop_size",
                    signed = true,
                    colour = G.C.FILTER
                }
            }
        }
    end
}