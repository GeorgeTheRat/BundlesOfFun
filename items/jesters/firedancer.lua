SMODS.Joker {
    key = "j_firedancer",
    name = "Firedancer",
    config = { extra = { dollars = 9 } },
    -- pos = { x = 0, y = 0 },
    cost = 6,
    rarity = 2,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calc_dollar_bonus = function(self, card)
        if SMODS.last_hand_oneshot and G.GAME.current_round.hands_left == 0 then
            return card.ability.extra.dollars
        end
    end
}