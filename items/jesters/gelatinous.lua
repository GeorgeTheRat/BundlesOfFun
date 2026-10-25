BundlesOfFun.Joker {
    key = "gelatinous",
    name = "Gelatinous Joker",
    bundle = "jesters",
    pos = { x = 8, y = 4 },
    config = {
        extra = {
            req = 3,
            count = 0
        }
    },
    attributes = { "rank", "modify_card" },
    cost = 8,
    rarity = 3,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.req,
                card.ability.extra.count
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            if next(context.poker_hands["Two Pair"]) then
                card.ability.extra.count = card.ability.extra.count + 1
                if card.ability.extra.count >= card.ability.extra.req then
                    card.ability.extra.count = 0
                    if BOF.nc(G.hand, "cards") then
                        local scoring_ranks = {}
                        for _, scoring_card in ipairs(context.scoring_hand) do
                            local rank_key = scoring_card.base.value
                            if rank_key and not scoring_ranks[rank_key] then
                                scoring_ranks[rank_key] = true
                            end
                        end
                        local rank_list = {}
                        for rank_key, _ in pairs(scoring_ranks) do
                            table.insert(rank_list, rank_key)
                        end
                        local hand_cards = {}
                        for _, hand_card in ipairs(G.hand.cards) do
                            table.insert(hand_cards, hand_card)
                        end
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                play_sound('tarot1')
                                card:juice_up(0.3, 0.5)
                                return true
                            end
                        }))
                        for i = 1, #hand_cards do
                            local percent = 1.15 - (i - 0.999) / (#hand_cards - 0.998) * 0.3
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.15,
                                func = function()
                                    hand_cards[i]:flip()
                                    play_sound('card1', percent)
                                    hand_cards[i]:juice_up(0.3, 0.3)
                                    return true
                                end
                            }))
                        end
                        delay(0.2)
                        for i = 1, #hand_cards do
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.1,
                                func = function()
                                    local _rank = pseudorandom_element(rank_list, "bof_gelatinous")
                                    SMODS.change_base(hand_cards[i], nil, _rank)
                                    return true
                                end
                            }))
                        end
                        for i = 1, #hand_cards do
                            local percent = 0.85 + (i - 0.999) / (#hand_cards - 0.998) * 0.3
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.15,
                                func = function()
                                    hand_cards[i]:flip()
                                    play_sound('tarot2', percent, 0.6)
                                    hand_cards[i]:juice_up(0.3, 0.3)
                                    return true
                                end
                            }))
                        end
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.2,
                            func = function()
                                G.hand:unhighlight_all()
                                return true
                            end
                        }))
                        delay(0.5)
                    end
                    return {
                        message = localize("k_transformed_ex"),
                        colour = G.C.GREEN
                    }
                end
            else
                card.ability.extra.count = 0
            end
        end
    end
}