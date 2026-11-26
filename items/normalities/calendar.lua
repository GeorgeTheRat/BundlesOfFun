local function change_calendar_shop_size(card, amount)
    if not G.GAME.shop then return false end
    if amount == 0 then return true end
    change_shop_size(amount)
    card.ability.extra.shop_size_applied = (card.ability.extra.shop_size_applied or 0) + amount
    return true
end

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
    blueprint_compat = false,
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
        card.ability.extra.og_shop_size = card.ability.extra.og_shop_size or card.ability.extra.shop_size
        card.ability.extra.shop_size_applied = card.ability.extra.shop_size_applied or 0
        G.E_MANAGER:add_event(Event({
            func = function()
                change_calendar_shop_size(card, card.ability.extra.shop_size)
                return true
            end
        }))
    end,
    calculate = function(self, card, context)
        if context.modify_final_cashout and card.ability.extra.shop_ended then
            local target_size = card.ability.extra.og_shop_size or card.ability.extra.shop_size
            local applied_size = card.ability.extra.shop_size_applied or 0
            if change_calendar_shop_size(card, target_size - applied_size) then
                card.ability.extra.shop_ended = nil
            end
        end
        if context.buying_card and context.card ~= card and card.ability.extra.shop_size > 0 then
            local size_change = math.min(
                -card.ability.extra.shop_size_mod,
                (card.ability.extra.shop_size_mod - card.ability.extra.shop_size) + 1
            )
            G.E_MANAGER:add_event(Event({
                func = function()
                    change_calendar_shop_size(card, size_change)
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
        if context.ending_shop and card.ability.extra.shop_size ~= card.ability.extra.og_shop_size then
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
                change_calendar_shop_size(card, -(card.ability.extra.shop_size_applied or 0))
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