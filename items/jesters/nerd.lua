BundlesOfFun.Joker {
    key = "nerd",
    name = "Nerd",
    bundle = "jesters",
    config = {
        extra = {
            rerolls = 5,
            tally = 1
        }
    },
    pos = { x = 6, y = 5 },
    attributes = { "passive" },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.rerolls } }
    end,
    calculate = function(self, card, context)
        if not next(SMODS.find_card("j_bof_pianoman")) then
            local go = G.GAME.round_scores.times_rerolled.amt % card.ability.extra.rerolls == 0 and G.GAME.round_scores.times_rerolled.amt ~= 0
            local reset = G.GAME.round_scores.times_rerolled.amt % card.ability.extra.rerolls == 1
            if context.create_shop_card and go and card.ability.extra.tally == 1 then
                card.ability.extra.tally = 0
                card:juice_up(0.3, 0.5)
                return {
                    shop_create_flags = {
                        set = "Joker",
                        rarity = "Rare"
                    }
                }
            end
            if context.create_shop_card and reset then
                card.ability.extra.tally = 1
            end
        end
    end
}