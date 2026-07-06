BundlesOfFun.Joker {
    key = "shrimp",
    name = "Shrimp",
    bundle = { "appetizers", { "fish" } },
    config = {
        extra = {
            packs = 5,
            packs_mod = 1
        }
    },
    pos = { x = 7, y = 4 },
    attributes = { "scaling", "generation", "passive", "food" },
    cost = 8,
    rarity = 3,
    eternal_compat = false,
    perishable_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.packs } }
    end,
    add_to_deck = function(self, card)
        G.GAME.modifiers.booster_size_mod = G.GAME.modifiers.booster_size_mod or 0
        G.GAME.modifiers.booster_size_mod = G.GAME.modifiers.booster_size_mod + 2
    end,
    calculate = function(self, card, context)
        if context.create_booster_card then
            local _size = math.max(1, context.booster.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))
            if context.index == _size - 1 then
                return {
                    booster_create_flags = {
                        set = "fish_s",
                        key_append = "j_bof_shrimp",
                        skip_materialize = true
                    }
                }
            elseif context.index == _size then
                return {
                    booster_create_flags = {
                        set = "fish_b",
                        key_append = "j_bof_shrimp",
                        skip_materialize = true
                    }
                }
            end
        end
        if context.ending_booster then
            if card.ability.extra.packs <= 1 then
                SMODS.destroy_cards(card, { pinch_anim = true })
                return {
                    message = localize("k_eaten_ex")
                }
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "packs",
                    scalar_value = "packs_mod",
                    operation = "-",
                    scaling_message = {
                        message = card.ability.extra.packs - 1
                    }
                })
            end
        end
    end,
    remove_from_deck = function(self, card)
        G.GAME.modifiers.booster_size_mod = G.GAME.modifiers.booster_size_mod or 0
        G.GAME.modifiers.booster_size_mod = G.GAME.modifiers.booster_size_mod - 2
    end
}