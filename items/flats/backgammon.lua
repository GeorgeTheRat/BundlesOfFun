BundlesOfFun.Back {
	key = "backgammon",
    name = "Backgammon Deck",
    bundle = "flats",
	atlas = "deck",
	pos = { x = 8, y = 0 },
    unlocked = false,
    calculate = function(self, card, context)
        if context.after and context.scoring_hand and (G.jokers and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit) then
            local cards_to_trigger = 0 -- this should be more than 0 unless you're playing with a mod that lets you play a hand without cards, or a mod that adds non-vanilla suits
            for i, other_card in ipairs(context.scoring_hand) do
                if other_card:is_suit("Spades") or other_card:is_suit("Clubs") or other_card:is_suit("Hearts") or other_card:is_suit("Diamonds") then
                    cards_to_trigger = cards_to_trigger + 1
                    local percent = 1.15 - (cards_to_trigger - 0.999) / (#context.scoring_hand - 0.998) * 0.3
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.15,
                        func = function()
                            other_card:flip()
                            play_sound("card1", percent)
                            other_card:juice_up(0.3, 0.3)
                            return true
                        end
                    }))
                end
            end
            if cards_to_trigger > 0 then
                delay(0.2)
                for _, other_card in ipairs(context.scoring_hand) do
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.1,
                        func = function()
                            other_card.ability.played_this_ante = false
                            if other_card.base.suit == "Spades" or other_card.base.suit == "Clubs" then -- base suit so wild cards arent changed to hearts or diamonds always
                                other_card:change_suit(pseudorandom_element({"Hearts", "Diamonds"}, pseudoseed("bof_backgammon_suit_change")))
                            elseif other_card.base.suit == "Hearts" or other_card.base.suit == "Diamonds" then
                                other_card:change_suit(pseudorandom_element({"Spades", "Clubs"}, pseudoseed("bof_backgammon_suit_change")))
                            end
                            other_card.ability.played_this_ante = true
                            return true
                        end
                    }))
                end
                for i, other_card in ipairs(context.scoring_hand) do
                    local percent = 0.85 + (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.15,
                        func = function()
                            if other_card.facing == "back" then
                                other_card:flip()
                                play_sound("tarot2", percent, 0.6)
                                other_card:juice_up(0.3, 0.3)
                            end
                            return true
                        end
                    }))
                end
                delay(2)
            end
            return nil, true
        end
    end,
    check_for_unlock = function(self, args)
        if args.type == "modify_deck" then
            for _, key in ipairs(SMODS.Suit.obj_buffer) do
                local count = 0
                for _, v in pairs(G.playing_cards) do
                    if v.base.suit == key then count = count + 1 end
                end
                if count ~= 10 then
                    return false
                end
            end
            return true
        end
    end
}
