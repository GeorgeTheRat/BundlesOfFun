-- rightmost joker is disabled
-- (applied by the lovely patch in lovely/risk.toml, which hooks Card:update to debuff the
-- rightmost joker and tracks it in G.GAME.bof_risk_joker - this just registers the blind)
BundlesOfFun.Blind {
    key = "risk",
    name = "The Risk",
    bundle = "enemies",
    pos = { y = 1 },
    atlas = "blind",
    boss = { min = 2 },
    boss_colour = HEX("fbe6cd")
}
