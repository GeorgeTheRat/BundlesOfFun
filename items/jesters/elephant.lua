BundlesOfFun.Joker {
    key = "elephant",
    name = "Elephant",
    bundle = "jesters",
    config = { extra = { chips = 70 } },
    pos = { x = 0, y = 3 },
    attributes = { "chips" },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            key = BundlesOfFun.config.evil_dih and "j_bof_address_me" or "j_bof_elephant",
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local all_same_rank = true
            local first_rank = context.full_hand[1].base.value
            for _, c in ipairs(context.full_hand) do
                if c.base.value ~= first_rank then
                    all_same_rank = false
                    break
                end
            end
            if all_same_rank then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end,
    set_sprites = function(self, card, initial)
        if self.discovered and BundlesOfFun.config.evil_dih then
            card.children.center.atlas = G.ASSET_ATLAS["bof_evil_dih"]
        end
	end,
    joker_display_def = function(JokerDisplay)
        return {
            -- mirrors calculate: only fires if every card shares same rank
            text = {
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "chips",
                    signed = true,
                    retrigger_type = "*",
                    colour = G.C.CHIPS
                }
            },
            calc_function = function(card)
                local hand = JokerDisplay.current_hand
                local active = false
                if hand and #hand > 0 then
                    active = true
                    local first_rank = hand[1].base.value
                    for _, c in ipairs(hand) do
                        if c.base.value ~= first_rank then
                            active = false
                            break
                        end
                    end
                end
                card.joker_display_values.chips = active and card.ability.extra.chips or 0
            end
        }
    end
}