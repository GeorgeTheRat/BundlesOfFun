SMODS.Joker {
    key = "f_manqian",
    name = "ManQian",
    pos = { x = 1, y = 4 },
    soul_pos = { x = 1, y = 5 },
    cost = 20,
    rarity = 4,
    unlocked = false,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local most_played = 0
        local most_played_hand
        for hand, data in pairs(G.GAME.hands) do
            if data.played > most_played then
                most_played = data.played
                most_played_hand = hand
            end
        end
        local hand_level = most_played_hand ~= nil and G.GAME.hands[most_played_hand].level or 0
        local hand_name = most_played_hand ~= nil and localize(most_played_hand, "poker_hands") or "None"
        local colour = (hand_level <= 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, hand_level)])
        return {
            vars = {
                hand_name,
                hand_level,
                colours = { colour }
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.initial_scoring_step then
            local most_played = 0
            local most_played_hand
            for hand, data in pairs(G.GAME.hands) do
                if data.played > most_played then
                    most_played = data.played
                    most_played_hand = hand
                end
            end
            local hand_level = most_played_hand ~= nil and G.GAME.hands[most_played_hand].level or 0
            return {
                Xmult = hand_level
            }
        end
    end
}