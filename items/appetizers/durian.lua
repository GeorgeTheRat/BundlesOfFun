SMODS.Joker {
    key = "a_durian",
    name = "Durian",
    pos = { x = 6, y = 0 },
    cost = 1,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_fool
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            for i = 1, G.consumeables.config.card_limit - #G.consumeables.cards do
                play_sound("timpani")
                card:juice_up(0.3, 0.5)
                SMODS.add_card({
                    key = "c_fool",
                    key_append = "bof_durian"
                })
            end
        end
    end
}