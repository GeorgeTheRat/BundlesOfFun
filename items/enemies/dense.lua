-- leftmost card in scoring hand is debuffed
-- (targeting happens in the G.FUNCS.evaluate_play hook in lib/hooks.lua, which marks the
-- card via card.ability.bof_dense_marked rather than stashing a card reference in G.GAME -
-- G.GAME gets fully serialized on autosave and a live Card reference in there can crash it)
BundlesOfFun.Blind {
    key = "dense",
    name = "The Dense",
    bundle = "enemies",
    pos = { y = 16 },
    atlas = "blind",
    boss = { min = 0 },
    boss_colour = HEX("689898"),
    calculate = function(self, blind, context)
        if context.blind_defeated or context.blind_disabled then
            BundlesOfFun.dense_clear_marks()
        end

        if blind.disabled then return end

        -- whether the card being asked about is the one that got marked
        if context.debuff_card then
            if context.debuff_card.ability and context.debuff_card.ability.bof_dense_marked then
                return {
                    debuff = true
                }
            end
        end
    end
}