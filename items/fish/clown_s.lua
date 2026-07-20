BundlesOfFun.Consumable {
    key = "clown_s",
    name = "Clownfish Small",
    bundle = "fish",
    set = "Fish",
    pools = { ["fish_s"] = true },
    pos = { x = 5, y = 0 },
    config = {
        card_limit = 1,
        extra = { rounds_remaining = 1 }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.card_limit,
                card.ability.extra.rounds_remaining
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local new_card = SMODS.add_card {
                            set = "Joker",
                            rarity = "Common",
                            key_append = "bof_clown_s"
                        }
                        new_card:start_materialize()
                        G.GAME.joker_buffer = 0
                        return true
                    end
                }))
                return {
                    message = localize("k_plus_joker"),
                    colour = G.C.BLUE
                }
            end
        end
        if context.end_of_round and context.main_eval and not context.repetition then
            if card.ability.extra.rounds_remaining > 1 then
                card.ability.extra.rounds_remaining = card.ability.extra.rounds_remaining - 1
                return {
                    message = card.ability.extra.rounds_remaining .. ""
                }
            else
                SMODS.destroy_cards(card, { pinch_anim = true })
                return {
                    message = localize("k_bof_expired")
                }
            end
        end
    end
}