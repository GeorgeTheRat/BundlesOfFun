-- voucher cannot be restocked next Ante - covers both the normal shop pick (blocked in
-- lib/hooks.lua's SMODS.add_voucher_to_shop/get_next_voucher_key hooks) and Lottery
-- Ticket's own "every 6 rerolls" ability (blocked separately, since that one replaces
-- the shop's voucher card directly instead of going through add_voucher_to_shop)
BundlesOfFun.Blind {
    key = "stress",
    name = "The Stress",
    bundle = "enemies",
    pos = { y = 17 },
    atlas = "blind",
    boss = { min = 4 },
    boss_colour = HEX("88b8b8"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        -- end_of_round, not blind_defeated: vanilla already regenerates next Ante's
        -- voucher pick in a step that runs after blind_defeated fires, so that'd be too late
        if context.end_of_round and context.main_eval then
            G.GAME.bof_stress_locked_ante = G.GAME.round_resets.ante + 1
        end
    end
}
