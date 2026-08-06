-- cards cannot be rearranged in hand
-- (actual effect lives in the CardArea:set_ranks hook in lib/hooks.lua - this just registers the blind)
BundlesOfFun.Blind {
    key = "decay",
    name = "The Decay",
    bundle = "enemies",
    pos = { y = 10 },
    atlas = "blind",
    boss = { min = 3 },
    boss_colour = HEX("d8a858")
}