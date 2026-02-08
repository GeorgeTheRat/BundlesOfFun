SMODS.Joker {
    key = "a_shrimp",
    name = "Fried Shrimp",
    config = {
        extra = {
            percent = 40,
            percent_mod = 5,
        }
    },
    pos = { x = 8, y = 0 },
    cost = 1,
    rarity = 2,
    order = 4,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.percent,
                card.ability.extra.percent_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if context.game_over then
                if G.GAME.chips / G.GAME.blind.chips > card.ability.extra.percent / 100 then
                    return {
                        saved = "k_bof_saved_by_shrimp",
                        message = localize("k_eaten_ex"),
                        --extra = {
                            func = function ()
                                SMODS.destroy_cards(card, true, nil, true)
                            end
                        --}
                    }
                end
            else
                card.ability.extra.percent = card.ability.extra.percent - card.ability.extra.percent_mod
                if card.ability.extra.percent > 0 then
                    return {
                        message = localize("k_bof_nom")
                    }
                else
                    return {
                        message = localize("k_eaten_ex"),
                        --extra = {
                            func = function ()
                                SMODS.destroy_cards(card, true, nil, true)
                            end
                        --}
                    }
                end
            end
        end
    end
}
