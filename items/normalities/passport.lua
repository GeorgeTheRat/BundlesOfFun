SMODS.Joker {
    key = "n_passport",
    name = "Passport",
    config = {
        extra = {
            chips_mod = 20,
            chips = 0,
            gonna_go = true
        }
    },
    pos = { x = 8, y = 3 },
    cost = 5,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips_mod,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            G.GAME.bof_passport_blinds = G.GAME.bof_passport_blinds or {}
            if not G.GAME.bof_passport_blinds[G.GAME.blind.config.blind.key] then
                G.GAME.bof_passport_blinds[G.GAME.blind.config.blind.key] = true
                card.ability.extra.gonna_go = true
            end
        end
        if context.end_of_round and context.main_eval and card.ability.extra.gonna_go and not context.blueprint then
            card.ability.extra.gonna_go = false
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chips_mod",
                message_colour = G.C.CHIPS
            })
        end
        if context.joker_main then
            return{
                chips = card.ability.extra.chips
            }
        end
    end
}