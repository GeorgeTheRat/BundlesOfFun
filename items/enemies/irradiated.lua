-- played cards do not give their base chips when scored
-- (handled directly in card.lua by the lovely patch in lovely/lightning.toml, name-matched
-- against "The Irradiated" and shared with the Lightning Deck's base-chip removal - nothing
-- in this file or lib/hooks.lua does the actual work)
BundlesOfFun.Blind {
    key = "irradiated",
    name = "The Irradiated",
    bundle = "enemies",
    pos = { y = 2 },
    atlas = "blind",
    boss = { min = 3 },
    boss_colour = HEX("e8dfc4")
}
