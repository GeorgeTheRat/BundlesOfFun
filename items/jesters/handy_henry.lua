SMODS.Joker {
    key = "j_handy_henry",
    name = "Handy Henry",
    config = {
        extra = {
            hand_amt = 1,
            handsize_amt = -1,
            pos = 1
        }
    },
    pos = { x = 3, y = 2 },
    cost = 5,
    rarity = 2,
    --order = 11,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hand_amt,
                card.ability.extra.handsize_amt,
            }
        }
    end,
    update = function (self, card, dt)
        if card.area ~= G.jokers then return end
        local pos
        for i,v in ipairs(G.jokers.cards) do
            if v == card then pos = i break end
        end
        if pos ~= card.ability.extra.pos then
            local delta = (pos - card.ability.extra.pos)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + (delta * card.ability.extra.hand_amt)
            ease_hands_played(delta * card.ability.extra.hand_amt)
            G.hand:change_size(delta * card.ability.extra.handsize_amt) --Somethin janky going on here but I can't work out what
            card.ability.extra.pos = pos
        end
    end
}
