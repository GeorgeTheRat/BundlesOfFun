SMODS.Joker {
    key = "j_hatty_hal",
    name = "Hatty Hal",
    config = {
        extra = {
            chip_gain = 1,
            chip_gaingain = 1,
            chips = 0
        }
    },
    pos = { x = 2, y = 2 },
    cost = 1,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
                cae.chip_gain, cae.chip_gaingain, cae.chips
            }
        }
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.playing_card_added and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = cae,
                ref_value = "chips",
                scalar_value = "chip_gain",
                colour = G.C.CHIPS
            })
            cae.chip_gain = cae.chip_gain+cae.chip_gaingain
        end
        if context.joker_main then
            return{
                chips = cae.chips
            }
        end
    end
}
