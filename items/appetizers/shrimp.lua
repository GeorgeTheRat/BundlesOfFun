SMODS.Joker {
    key = "a_shrimp",
    name = "Shrimp",
    config = {
        extra = {
            percent = 40,
            pctdrop = 5,
        }
    },
    pos = { x = 8, y = 0 },
    cost = 1,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.percent,
                card.ability.extra.pctdrop
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            if context.game_over then
                if G.GAME.chips/G.GAME.blind.chips > card.ability.extra.percent/100 then
                    return {
                        saved = "k_bof_savedbyshrimp",
                        message = localize("k_eaten_ex"),
                        --extra = {
                            func = function ()
                                SMODS.destroy_cards(card, true, nil, true)
                            end
                        --}
                    }
                end
            else
                card.ability.extra.percent = card.ability.extra.percent - card.ability.extra.pctdrop
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
