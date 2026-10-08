-- permanently debuff one random scoring card per hand
BundlesOfFun.Blind {
    key = "viscous",
    name = "The Viscous",
    bundle = "enemies",
    pos = { y = 6 },
    attributes = { "debuff" },
    atlas = "blind",
    boss = { min = 4 },
    boss_colour = HEX("61b0af"),
    calculate = function(self, blind, context)
        if context.blind_defeated or context.blind_disabled then
            G.GAME.bof_viscous_pending_card_id = nil
        end

        if blind.disabled then return end

        local function apply_debuff_by_id(id)
            if not id then return end
            for _, area in ipairs({ G.hand, G.play, G.discard, G.deck }) do
                if BOF.nc(area, "cards") then
                    for _, card in ipairs(area.cards) do
                        if card.sort_id == id and not card.ability.perma_debuff then
                            card.ability.perma_debuff = true
                            SMODS.recalc_debuff(card)
                            card:juice_up(0.3, 0.5)
                            blind:wiggle()
                            return
                        end
                    end
                end
            end
        end

        if context.final_scoring_step then
            local scoring = context.scoring_hand
            if scoring and #scoring > 0 then
                local target = pseudorandom_element(scoring, pseudoseed("bof_viscous"))
                if BOF.nc(target, "sort_id") and not target.ability.perma_debuff then
                    G.E_MANAGER:add_event(Event({
                        trigger = "immediate",
                        func = function()
                            apply_debuff_by_id(target.sort_id)
                            return true
                        end
                    }))
                end
            end
        end
    end
}