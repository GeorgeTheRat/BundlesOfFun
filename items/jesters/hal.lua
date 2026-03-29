SMODS.Joker {
    key = "j_hal",
    name = "Hatty Hal",
    config = {
        extra = {
            chips_mod = 1,
            chips_mod_mod = 1,
            chips = 0
        }
    },
    pos = { x = 2, y = 2 },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips_mod,
                card.ability.extra.chips_mod_mod,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.playing_card_added and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + #context.cards * card.ability.extra.chips_mod
            card.ability.extra.chips_mod = card.ability.extra.chips_mod + #context.cards * card.ability.extra.chips_mod_mod
            return {
                message = localize {"k_upgrade_ex"},
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}