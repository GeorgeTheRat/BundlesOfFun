-- cards cannot be rearranged
-- (actual effect lives in lib/hooks.lua - this just registers the blind)
BundlesOfFun.Blind {
    key = "decay",
    name = "The Decay",
    bundle = "enemies",
    pos = { y = 10 },
    attributes = { "position" },
    atlas = "blind",
    boss = { min = 3 },
    boss_colour = HEX("d8a858")
}