SMODS.Joker {
    key = "a_jelly_beans",
    name = "Jelly Beans",
    config = {
        extra = {
            create = 1
        }
    },
    pos = { x = 1, y = 0 },
    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.create
            }
        }
    end,
    calculate = function(self, card, context)
        if context.skip_blind then
            for i = 1, card.ability.extra.create do
                add_tag(Tag("tag_juggle"))
                card:juice_up(0.4, 0.4)
                play_sound("tarot1")
            end
            SMODS.destroy_cards(card, nil, nil, true)
            return {
                message = localize("k_eaten_ex")
            }
        end
    end
}