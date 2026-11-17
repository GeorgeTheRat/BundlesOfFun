BundlesOfFun.Joker {
    key = "synesthesiac",
    name = "Synesthesiac",
    bundle = "jesters",
    config = {
        extra = {
            mult = 3,
            fives = 0
        }
    },
    pos = { x = 5, y = 4 },
    attributes = { "mult", "rank", "five" },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local fives = card.added_to_deck and card.ability.extra.fives or G.GAME.bof_played_fives or 0
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.mult * fives
            }
        }
    end,
    add_to_deck = function(self, card)
        card.ability.extra.fives = G.GAME.bof_played_fives or 0
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult * card.ability.extra.fives
            }
        end
    end,
    joker_display_def = function()
        return {
            text = {
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "mult",
                    retrigger_type = "*",
                    signed = true,
                    colour = G.C.MULT 
                }
            },
            calc_function = function(card)
                local fives = card.added_to_deck and card.ability.extra.fives or G.GAME.bof_played_fives or 0
                card.joker_display_values.mult = card.ability.extra.mult * fives
            end
        }
    end
}
