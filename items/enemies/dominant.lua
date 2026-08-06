-- seals have no effect (Red retrigger, Gold $3, Purple tarot-on-discard, Blue end-of-round planet)
-- (actual suppression lives in lib/hooks.lua, since each of the four effects reads card.seal
-- from a different vanilla method - this file just registers the blind definition)
BundlesOfFun.Blind {
    key = "dominant",
    name = "The Dominant",
    bundle = "enemies",
    pos = { y = 0 },
    atlas = "blind",
    boss = { min = 5 },
    boss_colour = HEX("508e76")
}
