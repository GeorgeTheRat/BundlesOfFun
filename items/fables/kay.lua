BundlesOfFun.Joker {
    key = "kay",
    name = "Kay",
    bundle = "fables",
    pos = { x = 13, y = 6 },
    soul_pos = { x = 13, y = 7 },
    config = { extra = { xmult = 0.15 } },
    attributes = { "xmult", "perma_bonus", "enhancements" },
    cost = 20,
    rarity = 4,
    unlocked = false,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.before then
            local first_enhanced_card = nil
            local target_enhancement = nil
            for _, played_card in ipairs(context.full_hand) do
                local enhancements = SMODS.get_enhancements(played_card)
                if next(enhancements) and not first_enhanced_card then
                    first_enhanced_card = played_card
                    for enh_key, _ in pairs(enhancements) do
                        target_enhancement = enh_key
                        break
                    end
                end
            end
            if first_enhanced_card and target_enhancement then
                card.ability.bof_target_enhancement = target_enhancement
            end
        end
        if context.individual and context.cardarea == G.play and card.ability.bof_target_enhancement then
            local enhancements = SMODS.get_enhancements(context.other_card)
            if enhancements[card.ability.bof_target_enhancement] then
                context.other_card.ability.perma_x_mult = (context.other_card.ability.perma_x_mult or 0) + card.ability.extra.xmult
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.MULT
                }
            end
        end
    end
}
