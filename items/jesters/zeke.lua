BundlesOfFun.Joker {
    key = "zeke",
    name = "Zipper Zeke",
    bundle = "jesters",
    config = { extra = { odds = 2 } },
    pos = { x = 9, y = 4 },
    attributes = { "generation", "chance", "joker", "tarot" },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_bof_zeke")
        return {
            vars = {
                numerator,
                denominator
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_card and context.card and context.card.ability and context.card.ability.set == "Tarot" and SMODS.pseudorandom_probability(card, "j_bof_zeke", 1, card.ability.extra.odds) then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    if #G.jokers.cards < G.jokers.config.card_limit then
                        local rarity = 1
                        while rarity == 1 or rarity == 4 do
                            rarity = SMODS.poll_rarity("Joker", "j_bof_zeke")
                        end
                        if type(rarity) == "number" and rarity > 1 and rarity < 4 then
                            local rarity_names = { [2] = "Uncommon", [3] = "Rare" }
                            rarity = rarity_names[rarity]
                        end
                        local new_card = SMODS.add_card {
                            set = "Joker",
                            rarity = rarity,
                            key_append = "j_bof_zeke"
                        }
                        new_card:start_materialize()
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))
        end
    end
}