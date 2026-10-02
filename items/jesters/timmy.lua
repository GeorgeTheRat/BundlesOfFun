local function cards_above_deck()
    return math.max(0, #G.playing_cards - (G.GAME.starting_deck_size or 52))
end

BundlesOfFun.Joker {
    key = "timmy",
    name = "Little Timmy",
    bundle = "jesters",
    config = { extra = { chips = 8 } },
    pos = { x = 9, y = 1 },
    attributes = { "chips", "full_deck" },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                (G.GAME.starting_deck_size or 52),
                (G.playing_cards and cards_above_deck() or 0) * card.ability.extra.chips,
            }   
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips * cards_above_deck(),
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "chips",
                    signed = true,
                    colour = G.C.CHIPS
                }
            },
            calc_function = function(card)
                card.joker_display_values = card.joker_display_values or {}
                card.joker_display_values.chips = card.ability.extra.chips * cards_above_deck()
            end
        }
    end
}