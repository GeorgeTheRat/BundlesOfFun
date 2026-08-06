-- shuffle cards in played hand
-- (handled by the G.FUNCS.evaluate_play hook in lib/hooks.lua, right before scoring begins -
-- not context.press_play, since that fires before G.play.cards is even populated)
BundlesOfFun.Blind {
    key = "random",
    name = "The Random",
    bundle = "enemies",
    pos = { y = 13 },
    atlas = "blind",
    boss = { min = 2 },
    boss_colour = HEX("88b8b8")
}
