BundlesOfFun.Joker {
    key = "eddrick",
    name = "Evil Eddrick",
    bundle = "jesters",
    config = {
        extra = {
            chips = 50,
            mult = 10
        }
    },
    pos = { x = 6, y = 2 },
    attributes = { "mult", "chips", "hands" },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_left == 0 then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            -- mirrors calculate: only fires when this is the final hand of the round.
            -- hands_left decrements before joker_main runs for the hand being played, but this
            -- calc_function runs continuously pre-play (before that decrement happens) -- so
            -- while a hand is still just selected, "final hand" means hands_left == 1 (about to
            -- become 0), and only once G.play.cards is populated (hand already resolving) does
            -- hands_left == 0 directly match what calculate itself checks.
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS },
                { text = ", +" },
                { ref_table = "card.joker_display_values", ref_value = "mult",  colour = G.C.MULT }
            },
            calc_function = function(card)
                local playing_hand = next(G.play.cards)
                local hands_left = G.GAME.current_round and G.GAME.current_round.hands_left
                local active = playing_hand and hands_left == 0 or not playing_hand and hands_left == 1
                card.joker_display_values.chips = active and card.ability.extra.chips or 0
                card.joker_display_values.mult = active and card.ability.extra.mult or 0
            end
        }
    end
}