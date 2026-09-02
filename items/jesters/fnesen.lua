BundlesOfFun.Joker {
    key = "fnesen",
    name = "Fnesen",
    bundle = "jesters",
    config = {
        extra = {
            xmult = 4,
            prepped = true
        }
    },
    pos = { x = 5, y = 3 },
    attributes = { "xmult" },
    cost = 5,
    rarity = 2,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.debuff_card and context.debuff_card.area == G.jokers and context.debuff_card.ability.fnesen_chosen then
            return {
                debuff = true
            }
        end
        if context.press_play then
            card.ability.extra.prepped = true
        end
        if context.hand_drawn and card.ability.extra.prepped then
            for _, joker in pairs(G.jokers.cards) do
                joker.ability.fnesen_chosen = nil
                SMODS.recalc_debuff(joker)
            end
            card.ability.extra.prepped = false
            local prev_chosen_set = {}
            local fallback_jokers = {}
            local jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.fnesen_chosen then
                    prev_chosen_set[G.jokers.cards[i]] = true
                    G.jokers.cards[i].ability.fnesen_chosen = nil
                    if G.jokers.cards[i].debuff then
                        SMODS.recalc_debuff(G.jokers.cards[i])
                    end
                end
            end
            for i = 1, #G.jokers.cards do
                if not G.jokers.cards[i].debuff then
                    if not prev_chosen_set[G.jokers.cards[i]] then
                        jokers[#jokers + 1] = G.jokers.cards[i]
                    end
                    table.insert(fallback_jokers, G.jokers.cards[i])
                end
            end
            if #jokers == 0 then jokers = fallback_jokers end
            local _card = pseudorandom_element(jokers, "bof_fnesen")
            if _card then
                _card.ability.fnesen_chosen = true
                SMODS.recalc_debuff(_card)
                _card:juice_up()
                card:juice_up(0.3, 0.5)
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    blockable = false,
                    blocking = false,
                    func = function()
                        play_sound("tarot2", 0.76, 0.4)
                        return true 
                    end
                }))
                play_sound("tarot2", 1, 0.4)
            end
        end
        if context.selling_self or context.blind_defeated then
            for _, joker in pairs(G.jokers.cards) do
                if joker.ability.fnesen_chosen then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:juice_up(0.3, 0.5)
                            for _, j in pairs(G.jokers.cards) do
                                if j.ability.fnesen_chosen then
                                    j.ability.fnesen_chosen = nil
                                    SMODS.recalc_debuff(j)
                                    G.E_MANAGER:add_event(Event({
                                        trigger = "after",
                                        delay = 0.4,
                                        blockable = false,
                                        blocking = false,
                                        func = function()
                                            play_sound("tarot2", 0.76, 0.4)
                                            return true 
                                        end
                                    }))
                                    play_sound("tarot2", 1, 0.4)
                                end
                            end
                            return true
                        end
                    }))
                    break
                end
            end
        end
        if context.joker_main and card.debuff then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}