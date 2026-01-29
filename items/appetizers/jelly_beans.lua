SMODS.Joker {
    key = "a_jelly_beans",
    name = "Jelly Beans",
    config = {
        extra = {
            blinds = 2
        }
    },
    pos = { x = 1, y = 0 },
    cost = 3,
    rarity = 1,
    order = 7,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_juggle
        return { vars = { card.ability.extra.blinds } }
    end,
    calculate = function(self, card, context)
        if context.skip_blind then
            card.ability.extra.blinds = card.ability.extra.blinds - 1
            add_tag(Tag("tag_juggle"))
            card:juice_up(0.4, 0.4)
            play_sound("tarot1")
            if card.ability.extra.blinds <= 0 then
                SMODS.destroy_cards(card, true, nil, true)
                return {
                    message = localize("k_eaten_ex")
                }
            end
        end
    end
}