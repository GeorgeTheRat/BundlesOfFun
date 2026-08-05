-- only three cards may be visible at once
BundlesOfFun.Blind {
    key = "circuit",
    name = "The Circuit",
    bundle = "enemies",
    pos = { y = 19 },
    atlas = "blind",
    boss = { min = 6 }, -- this feels way too punishing IMO too put anywhere under this
    boss_colour = HEX("e88868"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        -- deal face down whenever 3 cards already in hand are face up
        -- (counts currently face-up cards, so more get revealed as
        -- visible ones are played/discarded across the round)
        if context.stay_flipped and context.to_area == G.hand then
            local visible = 0
            for _, c in ipairs(G.hand.cards) do
                if c.facing == 'front' then visible = visible + 1 end
            end
            if visible >= 3 then
                return { stay_flipped = true }
            end
        end
    end
}
