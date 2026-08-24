-- all rare jokers are disabled until the final hand
BundlesOfFun.Blind {
    key = "damping",
    name = "The Damping",
    bundle = "enemies",
    pos = { y = 5 },
    atlas = "blind",
    boss = { min = 4 },
    boss_colour = HEX("8e7cca"),
    calculate = function(self, blind, context)
        -- clear the flags and let jokers recalculate once the blind's gone
        if context.blind_disabled or context.blind_defeated then
            for _, joker in ipairs(G.jokers.cards) do
                if joker.ability.damping_chosen then
                    joker.ability.damping_chosen = nil
                    SMODS.recalc_debuff(joker)
                end
            end
        end

        if blind.disabled then return end

        -- debuff any joker flagged by the hand_drawn check below
        if context.debuff_card and context.debuff_card.area == G.jokers then
            if context.debuff_card.ability.damping_chosen then
                return { debuff = true }
            end
        end

        -- flag every rare joker for debuff, except on the final hand of the round
        if context.hand_drawn then
            local is_final_hand = G.GAME.current_round.hands_left == 1
            local changed = false

            for _, joker in ipairs(G.jokers.cards) do
                local center = joker.config and joker.config.center
                local is_rare = center and center.rarity == 3
                local should_debuff = is_rare and not is_final_hand

                if joker.ability.damping_chosen ~= should_debuff then
                    joker.ability.damping_chosen = should_debuff
                    SMODS.recalc_debuff(joker)
                    if should_debuff then joker:juice_up() end
                    changed = true
                end
            end
            if changed then blind:wiggle() end
        end
    end
}