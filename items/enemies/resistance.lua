-- no payout from blind, hands, discards, or interest
-- (lib/hooks.lua reads the flag below to zero the blind's dollar reward and suppress
-- hand/discard bonus money and interest for that one round - Joker payouts still happen)
--
-- i really couldnt find a good way too just remove/skip the payout fully,
-- so this is what we come out with, it's pretty much the same power wise,
-- only thing is if a joker shows on payout, or a tag, both of which were causing issues,
-- being why i did it this way instead
BundlesOfFun.Blind {
    key = "resistance",
    name = "The Resistance",
    bundle = "enemies",
    pos = { y = 24 },
    atlas = "blind",
    boss = { min = 2 },
    boss_colour = HEX("28a8d8"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.end_of_round and context.main_eval then
            G.GAME.bof_resistance_active = true
        end
    end
}