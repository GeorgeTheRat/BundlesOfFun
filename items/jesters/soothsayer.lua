SMODS.Joker {
    key = "j_soothsayer",
    name = "Soothsayer",
    pos = { x = 3, y = 3 },
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.hand and context.individual then
            if context.other_card.seal and context.other_card.seal == "Purple" then
                SMODS.add_card{set = "Tarot"}
                return { message = localize('k_plus_tarot'), colour = G.C.PURPLE, message_card = v }
            end
        end
        if context.pre_discard and not context.hook then
            for k, v in pairs(context.full_hand) do
                if v.seal and v.seal == "Blue" then
                    local text, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
                    return {
                        level_up = true,
                        level_up_hand = text
                    }
                end
            end
        end
    end
}