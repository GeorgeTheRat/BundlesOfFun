BundlesOfFun.Back {
	key = "tiled",
    name = "Tiled Deck",
    bundle = "flats",
	atlas = "deck",
	pos = { x = 8, y = 0 },
    attributes = { "suit", "modify_card" },
    unlocked = false,
    calculate = function(self, card, context)
        if context.after and context.scoring_hand and (BOF.nc(G.jokers, "cards") and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit) then
            local cards_to_trigger = 0 -- this should be more than 0 unless you're playing with a mod that lets you play a hand without cards, or a mod that adds non-vanilla suits
            for i, other_card in ipairs(context.scoring_hand) do
                if other_card:is_suit_shade("dark") or other_card:is_suit_shade("light") then
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
                            if other_card:bof_is_true_suit_shade("dark") then -- base suit so wild cards arent changed to hearts or diamonds always
                                other_card:change_suit(pseudorandom_element({ "Hearts", "Diamonds" }, pseudoseed("bof_tiled")))
                            elseif other_card:bof_is_true_suit_shade("light") then
                                other_card:change_suit(pseudorandom_element({ "Spades", "Clubs" }, pseudoseed("bof_tiled")))
                            end
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
        if args and args.type == "modify_deck" and BOF.nc(G.GAME, "blind") then
            local first_suit = nil
            for _, card in ipairs(G.playing_cards or {}) do
                local suit = BOF.nc(card, "base", "suit")
                if suit then
                    if not first_suit then
                        first_suit = suit
                    elseif suit ~= first_suit then
                        return false
                    end
                end
            end
            if first_suit then
                return true
            end
        end
    end
}