SMODS.Joker {
    key = "n_rummikup_tile",
    name = "Rummikup Tile",
    config = { extra = { 
        chips = 0,
        chip_gain = 10,
        chip_threshold = 30
    } },
    pos = { x = 7, y = 3 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return { vars = { cae.chips, cae.chip_gain, cae.chip_threshold } }
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.before then
            local total = 0
            for k, v in pairs(G.play.cards) do
                total = total + v.base.nominal
            end
            if total >= cae.chip_threshold  then
                SMODS.scale_card(card, {
                    ref_table = cae,
                    ref_value = "chips",
                    scalar_value = "chip_gain"
                })
            end
        end
        if context.joker_main then
            return{
                chips = cae.chips
            }
        end
    end
}