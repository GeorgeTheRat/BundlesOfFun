BundlesOfFun.Joker {
    key = "director",
    name = "Director",
    bundle = "jesters",
    config = { extra = { xmult = 1.25 } },
    pos = { x = 8, y = 4 },
    attributes = { "xmult", "retrigger" },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.retrigger_joker_check and context.other_card == card then
            local count = 0
            if G.play.cards and next(G.play.cards) then
                for k, v in pairs(G.play.cards) do
                    if v.bof_retriggered then
                        count = count + 1
                    end
                end
                return {
                    repetitions = count
                }
            end
        end
    end
}