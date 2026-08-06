-- Small Blind next Ante is unskippable and large (1.5x chip requirement)
-- (lib/hooks.lua does the actual work off the flag set below: no-ops skip_blind and
-- multiplies that Small Blind's chips by 1.5 in Blind:set_blind)
BundlesOfFun.Blind {
    key = "tiny",
    name = "The Tiny",
    bundle = "enemies",
    pos = { y = 4 },
    atlas = "blind",
    boss = { min = 2 },
    boss_colour = HEX("f85858"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.blind_defeated or context.end_of_round then
            G.GAME.bof_tiny_active = true
        end
    end
}
