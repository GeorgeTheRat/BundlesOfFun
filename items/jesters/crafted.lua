BundlesOfFun.Joker {
    key = "crafted",
    name = "Crafted Joker",
    bundle = "jesters",
    config = { extra = { bof_crafted_target = nil } },
    pos = { x = 5, y = 2 },
    attributes = { "destroy_card", "enhancements", "seals", "editions" },
    cost = 6,
    rarity = 2,
    atlas = "joker",
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "k_bof_modification" }
    end,
    calculate = function(self, card, context)
        if context.final_scoring_step and G.GAME.current_round.hands_played == 0 and not context.blueprint then
            local left_card, right_card = context.full_hand[1], context.full_hand[#context.full_hand]
            if left_card and right_card and left_card ~= right_card then
                local has_modifications = false
                local enh = SMODS.get_enhancements(left_card) or {}
                if next(enh) then
                    for k, _ in pairs(SMODS.get_enhancements(right_card) or {}) do
                        right_card:set_ability(G.P_CENTERS[k], nil, true)
                    end
                    for k, v in pairs(enh) do
                        right_card:set_ability(G.P_CENTERS[k], v, true)
                    end
                    has_modifications = true
                end
                if left_card.edition and left_card.edition ~= "Base" then
                    right_card:set_edition(left_card.edition, nil, nil, true)
                    has_modifications = true
                end
                local seal = left_card:get_seal(true)
                if seal then
                    -- match Eraser: prevent seal-trigger while we copy it
                    right_card.ability = right_card.ability or {}
                    right_card.ability.bof_delay_seal_removal = true
                    right_card:set_seal(seal)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            right_card.ability.bof_delay_seal_removal = nil
                            return true
                        end
                    }))
                    has_modifications = true
                end
                if has_modifications then
                    card.ability.extra.bof_crafted_target = left_card
                    return {
                        message = localize("k_copied_ex")
                    }
                end
            end
        end
        if context.destroy_card and (context.cardarea == G.play or context.cardarea == "unscored") and card.ability.extra.bof_crafted_target then
            if context.destroy_card == card.ability.extra.bof_crafted_target then
                card.ability.extra.bof_crafted_target = nil
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return {
                    remove = true
                }
            end
        end
    end
}