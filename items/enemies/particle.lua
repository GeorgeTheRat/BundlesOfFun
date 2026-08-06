-- cannot skip the Small Blind and Big Blind next Ante
-- (lib/hooks.lua does the actual skip-blocking, keyed off the flag set below,
-- and clears it once that Ante's boss is faced)
BundlesOfFun.Blind {
    key = "particle",
    name = "The Particle",
    bundle = "enemies",
    pos = { y = 20 },
    atlas = "blind",
    boss = { min = 2 },
    boss_colour = HEX("d86878"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.blind_defeated then
            G.GAME.bof_particle_active = true
        end
    end
}
