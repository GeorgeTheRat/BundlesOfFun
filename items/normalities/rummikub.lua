SMODS.Joker {
    key = "n_rummikub",
    name = "Rummikub Tile",
    config = {
        extra = { 
            chips = 0,
            chips_mod = 5,
            chips_threshold = 30
        }
    },
    pos = { x = 7, y = 3 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips_mod,
                card.ability.extra.chips_threshold,
                card.ability.extra.chips
            } 
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            local total = 0
            for k, v in pairs(G.play.cards) do
                total = total + v.base.nominal
            end
            if total >= card.ability.extra.chips_threshold  then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "chips_mod",
                    message_colour = G.C.CHIPS
                })
            end
        end
        if context.joker_main then
            return{
                chips = card.ability.extra.chips
            }
        end
    end
}