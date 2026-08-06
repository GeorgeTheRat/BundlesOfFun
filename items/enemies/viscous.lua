-- permanently debuff one random scoring card per hand
BundlesOfFun.Blind {
    key = "viscous",
    name = "The Viscous",
    bundle = "enemies",
    pos = { y = 6 },
    atlas = "blind",
    boss = { min = 1 },
    boss_colour = HEX("61b0af"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        -- reset the per-hand guard on every draw
        if context.hand_drawn then
            G.GAME.bof_viscous_hand_done = nil
        end

        -- on the first individual scoring eval of the hand, pick a random scoring card
        -- and mark it permanently debuffed (ability.perma_debuff is a vanilla field)
        if context.individual and context.cardarea == G.play and not G.GAME.bof_viscous_hand_done then
            G.GAME.bof_viscous_hand_done = true
            local scoring = context.scoring_hand
            if scoring and #scoring > 0 then
                local target = pseudorandom_element(scoring, pseudoseed("bof_viscous"))
                if target and not target.ability.perma_debuff then
                    target.ability.perma_debuff = true
                    SMODS.recalc_debuff(target)
                    blind:wiggle()
                end
            end
        end
    end
}
