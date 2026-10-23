BundlesOfFun.Joker {
    key = "anvil",
    name = "Anvil",
    bundle = "normalities",
    -- pos = { x = 9, y = 5 },
    attributes = { "rank" },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "placeholder",
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local highest_rank = -1
            for _, played_card in ipairs(context.full_hand) do
                local card_id = played_card:get_id()
                if card_id > highest_rank then
                    highest_rank = card_id
                end
            end
            if context.other_card:get_id() == highest_rank then
                local target_card = context.other_card
                return {
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.2,
                            func = function()
                                play_sound("tarot1")
                                target_card:juice_up(0.3, 0.5)
                                return true
                            end
                        }))
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.15,
                            func = function()
                                target_card:flip()
                                play_sound("card1")
                                target_card:juice_up(0.3, 0.3)
                                return true
                            end
                        }))
                        delay(0.2)
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.1,
                            func = function()
                                assert(SMODS.modify_rank(target_card, -1))
                                return true
                            end
                        }))
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.15,
                            func = function()
                                target_card:flip()
                                play_sound("tarot2", 1, 0.6)
                                target_card:juice_up(0.3, 0.3)
                                return true
                            end
                        }))
                    end
                }
            end
        end
    end
}