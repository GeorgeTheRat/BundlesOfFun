BundlesOfFun.Joker {
    key = "tom",
    name = "Tumor Tom",
    bundle = "jesters",
    config = {
        card_limit = 2,
        extra = { consumable_slots = 1 }
    },
    pos = { x = 2, y = 2 },
    attributes = { "joker_slot", "consumable_slot" },
    cost = 8,
    rarity = 3,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local main_end = {}
        if G.jokers and (#G.jokers.cards >= G.jokers.config.card_limit) and next(SMODS.find_card("j_bof_tom")) then
            localize({ type = "other", key = "k_bof_tom_sell", nodes = main_end })
        end
        return {
            vars = {
                card.ability.card_limit,
                card.ability.extra.consumable_slots
            },
            main_end = main_end[1]
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.consumeables:change_size(-card.ability.extra.consumable_slots)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables:change_size(card.ability.extra.consumable_slots)
    end,
    can_sell = function(self, card, context)
        if G.jokers and (#G.jokers.cards >= G.jokers.config.card_limit) then
            return false
        end
        return true
    end
}