SMODS.Joker {
    key = "j_handy_henry",
    name = "Handy Henry",
    config = {
        extra = {
            hands = 1,
            hand_size = -1,
            pos = 1
        }
    },
    pos = { x = 3, y = 2 },
    cost = 5,
    rarity = 2,
    order = 12,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hands,
                card.ability.extra.hand_size,
            }
        }
    end,
    update = function(self, card, dt)
        if card.area == G.jokers then
            local pos
            for i, v in ipairs(G.jokers.cards) do
                if v == card then
                    pos = i
                    break
                end
            end
            if pos ~= card.ability.extra.pos then
                local delta = (pos - card.ability.extra.pos)
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + (delta * card.ability.extra.hands)
                ease_hands_played(delta * card.ability.extra.hands)
                G.hand:change_size(delta * card.ability.extra.hand_size) -- Somethin janky going on here but I can't work out what
                card.ability.extra.pos = pos
            end
        end
    end
}