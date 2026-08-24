-- permanently debuff one random scoring card per hand
BundlesOfFun.Blind {
    key = "viscous",
    name = "The Viscous",
    bundle = "enemies",
    pos = { y = 6 },
    atlas = "blind",
    boss = { min = 4 },
    boss_colour = HEX("61b0af"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        -- applies the card picked by the previous hand's context.after, right as the
        -- next hand is drawn - context.after fires before the just-played hand's score
        -- animation has finished, so debuffing there immediately made the card visibly
        -- grey out while it was still on screen scoring. tracked by sort_id (not a live
        -- card reference) since it has to survive in G.GAME across that gap - see the
        -- same pattern in angle.lua's bof_angle_discarded_cards
        if context.hand_drawn and G.GAME.bof_viscous_pending_card_id then
            local id = G.GAME.bof_viscous_pending_card_id
            G.GAME.bof_viscous_pending_card_id = nil
            for _, area in ipairs({ G.hand, G.play, G.discard, G.deck }) do
                if area and area.cards then
                    for _, card in ipairs(area.cards) do
                        if card.sort_id == id and not card.ability.perma_debuff then
                            card.ability.perma_debuff = true
                            SMODS.recalc_debuff(card)
                            blind:wiggle()
                            break
                        end
                    end
                end
            end
        end

        -- fires once per hand, after scoring's fully resolved, so the picked card
        -- still scores this hand and is only (visually) debuffed starting next hand
        if context.after then
            local scoring = context.scoring_hand
            if scoring and #scoring > 0 then
                local target = pseudorandom_element(scoring, pseudoseed("bof_viscous"))
                if target and target.sort_id and not target.ability.perma_debuff then
                    G.GAME.bof_viscous_pending_card_id = target.sort_id
                end
            end
        end
    end
}