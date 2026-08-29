-- 1 in 4 chance to discard modified cards when drawn
BundlesOfFun.Blind {
    key = "average",
    name = "The Average",
    bundle = "enemies",
    pos = { y = 11 },
    atlas = "blind",
    boss = { min = 4 },
    boss_colour = HEX("588878"),
    vars = { 1, 4 },
    calculate = function(self, blind, context)
        if blind.disabled then return end

        -- every card drawn with an Enhancement, Edition, or Seal gets a 25% roll to be discarded
        -- (pseudorandom_probability, not a raw pseudorandom roll, so Oops! All 6s etc. still apply)
        if context.hand_drawn then
            local to_discard = {}
            for _, card in ipairs(context.hand_drawn) do
                local modified = next(SMODS.get_enhancements(card))
                    or (card.edition and card.edition ~= "Base")
                    or card:get_seal(true)
                if modified and SMODS.pseudorandom_probability(card, "bof_average", 1, 4) then
                    table.insert(to_discard, card)
                end
            end
            for _, card in ipairs(to_discard) do
                card.ability.discarded = true
                draw_card(G.hand, G.discard, 50, "down", false, card)
            end
            -- refill the hand so it doesn't stay short for the rest of the hand
            if #to_discard > 0 then
                blind:wiggle()
                G.E_MANAGER:add_event(Event({
                    trigger = "immediate",
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            trigger = "immediate",
                            func = function()
                                G.FUNCS.draw_from_deck_to_hand()
                                return true
                            end
                        }))
                        return true
                    end
                }))
            end
        end
    end,
    -- reflects the odds when the description is (re)built (blind start/disable/defeat)
    -- same "doesn't live-update mid-round" behavior as vanilla The Wheel
    loc_vars = function(self)
        local numerator, denominator = 1, 4
        if G.GAME and G.STAGE == G.STAGES.RUN then
            numerator, denominator = SMODS.get_probability_vars(nil, 1, 4, "bof_average")
        end
        return { vars = { numerator or 1, denominator or 4 } }
    end
}