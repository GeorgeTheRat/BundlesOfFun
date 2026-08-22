BundlesOfFun.Joker {
    key = "candy",
    name = "Pocket Candy",
    bundle = "appetizers",
    config = { extra = { blinds = 3 } },
    pos = { x = 6, y = 0 },
    attributes = { "scaling", "generation", "tag", "skip", "food" },
    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
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
            if card.ability.extra.blinds <= 0 and not context.blueprint then
                SMODS.destroy_cards(card, { pinch_anim = true })
                return {
                    message = localize("k_eaten_ex")
                }
            end
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            reminder_text = {
                { text = "(" },
                { ref_table = "card.ability.extra", ref_value = "blinds" },
                { text = "/" },
                { ref_table = "card.joker_display_values", ref_value = "start_count" },
                { text = ")" },
            },
            reminder_text_config = { scale = 0.35 },
            calc_function = function(card)
                card.joker_display_values.start_count = card.joker_display_values.start_count or card.ability.extra.blinds
            end,
            style_function = function(card, text, reminder_text, extra)
                local children = reminder_text and reminder_text.children
                if not children then
                    return
                end
                local colour = (card.ability.extra.blinds == 1) and G.C.RED or G.C.UI.TEXT_INACTIVE
                for i = 2, 4 do 
                    local child = children[i]
                    if child then child.config.colour = colour end
                end
            end
        }
    end
}