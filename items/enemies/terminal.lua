-- last scored rank is debuffed next hand
-- (complete rework - the original "last Joker ability is ignored" idea went through several
-- implementations that kept finding new gaps, and eventually a live-card-in-G.GAME crash;
-- "last scored rank" keeps the "last X" theme but needs no evaluation-order tracking at all)
--
-- recalc debuff status for every card in the deck (draw pile, hand, play, discard)
-- cause I'm dumb and didn't think about in the deck somehow
--
-- this shit was annoying; but still infinitely easier too make than the old effect,
-- that had it's own problems anyways though
local function bof_terminal_recalc_all()
    for _, area in ipairs({ G.deck, G.hand, G.play, G.discard }) do
        if area and area.cards then
            for _, card in ipairs(area.cards) do
                SMODS.recalc_debuff(card)
            end
        end
    end
end

BundlesOfFun.Blind {
    key = "terminal",
    name = "The Terminal",
    bundle = "enemies",
    pos = { y = 18 },
    atlas = "blind",
    boss = { min = 3 },
    boss_colour = HEX("588888"),
    calculate = function(self, blind, context)
        if context.blind_defeated or context.blind_disabled then
            G.GAME.bof_terminal_pending_rank = nil
            if G.GAME.bof_terminal_debuffed_rank then
                G.GAME.bof_terminal_debuffed_rank = nil
                bof_terminal_recalc_all()
            end
        end

        if blind.disabled then return end

        -- whether the card being asked about matches the tracked rank
        if context.debuff_card then
            local rank = G.GAME.bof_terminal_debuffed_rank
            if rank and context.debuff_card.base and context.debuff_card.base.id == rank then
                return { debuff = true }
            end
            return
        end

        -- applies the rank computed by the previous hand's context.after, right as the
        -- next hand is drawn - context.hand_drawn fires once per hand drawn (not once
        -- per encounter, despite what an earlier version of this comment assumed), so
        -- this needs no artificial delay to avoid flashing over the still-visible scored cards
        if context.hand_drawn and G.GAME.bof_terminal_pending_rank then
            G.GAME.bof_terminal_debuffed_rank = G.GAME.bof_terminal_pending_rank
            G.GAME.bof_terminal_pending_rank = nil
            bof_terminal_recalc_all()
            blind:wiggle()
        end

        -- fires once per hand, after scoring's fully resolved - walk scoring_hand backward
        -- for the last card that actually scored (hand membership isn't the same as scoring;
        -- a debuffed card stays in the array but contributes nothing)
        if context.after then
            local scoring_hand = context.scoring_hand
            local last_card = nil
            if scoring_hand then
                for i = #scoring_hand, 1, -1 do
                    if not scoring_hand[i].debuff then
                        last_card = scoring_hand[i]
                        break
                    end
                end
            end
            local new_rank = last_card and last_card.base and last_card.base.id
            if new_rank then
                G.GAME.bof_terminal_pending_rank = new_rank
            end
        end

        -- rank changes (Strength, etc.) fire before the card's base actually updates,
        -- so defer the recalc a tick or it'll check against the old rank
        if context.change_rank and context.other_card then
            local card = context.other_card
            G.E_MANAGER:add_event(Event({
                trigger = "immediate",
                func = function()
                    SMODS.recalc_debuff(card)
                    return true
                end
            }))
        end
    end,
    get_loc_debuff_text = function(self)
        return localize("bl_bof_terminal")
    end
}
