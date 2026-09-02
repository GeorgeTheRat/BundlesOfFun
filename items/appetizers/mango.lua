BundlesOfFun.Joker {
    key = "mango",
    name = "Mango",
    bundle = "appetizers",
    config = {
        extra = {
            count = 4,
            count_mod = 1
        }
    },
    pos = { x = 12, y = 0 },
    attributes = { "playing_card", "enhancements", "editions", "food" },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.count,
                card.ability.extra.count_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local cards_added = {}
            for i = 1, card.ability.extra.count do
                local card_added = SMODS.create_card {
                    set = "Enhanced",
                    edition = SMODS.poll_edition({
                        key = "bof_mango",
                        no_negative = true,
                        guaranteed = true
                    }),
                    area = G.discard
                }
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                card_added.playing_card = G.playing_card
                table.insert(G.playing_cards, card_added)
                table.insert(cards_added, card_added)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_added:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                        G.play:emplace(card_added)
                        return true
                    end
                }))
            end
            return {
                message = localize{ type = "variable", key = (card.ability.extra.count == 1 and "a_bof_plus_card" or "a_bof_plus_cards"), vars = { card.ability.extra.count } },
                func = function()
                    G.deck.config.card_limit = G.deck.config.card_limit + #cards_added
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.4 * #cards_added,
                        func = function()
                            for _, card_added in ipairs(cards_added) do
                                draw_card(G.play, G.deck, 90, "up")
                                SMODS.calculate_context({ playing_card_added = true, cards = { card_added } })
                            end
                            return true
                        end
                    }))
                end
            }
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
            if card.ability.extra.count <= card.ability.extra.count_mod then
                SMODS.destroy_cards(card, { pinch_anim = true })
                return {
                    message = localize("k_eaten_ex")
                }
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "count",
                    operation = "-",
                    scalar_value = "count_mod",
                    scaling_message = {
                        message = "-" .. card.ability.extra.count_mod
                    }
                })
            end
        end
    end
}