SMODS.Joker {
    key = "j_sword_swallower",
    name = "Sword Swallower",
    config = { extra = { odds = 3 } },
    -- pos = { x = 4, y = 1 },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_bof_j_sword_swallower")
        return {
            vars = {
                numerator,
                denominator
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_card and context.card.ability.set == "Tarot" and SMODS.pseudorandom_probability(card, "j_bof_j_sword_swallower", 1, card.ability.extra.odds) then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    if G.jokers.config.card_limit - #G.jokers.cards >= 1 then
                        local rarity = 1
                        while rarity == 1 or rarity == 4 do
                            rarity = SMODS.poll_rarity("Joker", "j_bof_j_sword_swallower")
                        end
                        if type(rarity) == "number" and rarity > 1 and rarity < 4 then
                            local rarity_names = { [2] = "Uncommon", [3] = "Rare" }
                            rarity = rarity_names[rarity]
                        end
                        SMODS.add_card {
                            set = "Joker",
                            rarity = rarity,
                            key_append = "j_bof_j_sword_swallower",
                            allow_duplicates = false
                        }
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))
        end
    end
}