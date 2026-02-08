SMODS.Joker {
    key = "j_gumphrey",
    name = "Gumphrey",
    config = {
        extra = {
            mult_mod = 2,
            mult = 0
        }
    },
    pos = { x = 1, y = 1 },
    cost = 5,
    rarity = 1,
    order = 25,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local enhanced_count = 0
        if G.playing_cards ~= nil then
            for k, v in pairs(G.playing_cards) do
                if v.config.center ~= G.P_CENTERS.c_base then
                    enhanced_count = enhanced_count + 1
                end
            end
        end
        return {
            vars = {
                card.ability.extra.mult_mod,
                enhanced_count * card.ability.extra.mult_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
    update = function(self, card, dt)
        if G.playing_cards ~= nil then
            local enhanced_count = 0
            for k, v in pairs(G.playing_cards) do
                if v.config.center ~= G.P_CENTERS.c_base then
                    enhanced_count = enhanced_count + 1
                end
            end
            card.ability.extra.mult = enhanced_count * card.ability.extra.mult_mod
        end
    end
}