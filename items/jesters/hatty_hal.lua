SMODS.Joker {
    key = "j_hatty_hal",
    name = "Hatty Hal",
    config = {
        extra = {
            chip_mod = 1,
            chip_mod_mod = 1,
            chips = 0
        }
    },
    pos = { x = 2, y = 2 },
    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chip_mod,
                card.ability.extra.chip_mod_mod,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.playing_card_added and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chip_mod",
                colour = G.C.CHIPS
            })
            card.ability.extra.chip_mod = card.ability.extra.chip_mod + card.ability.extra.chip_mod_mod
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}