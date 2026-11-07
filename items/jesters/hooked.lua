BundlesOfFun.Joker {
    key = "hooked",
    name = "Hooked Joker",
    bundle = { "jesters", { "minnows" } },
    config = { extra = { odds = 3 } },
    pos = { x = 12, y = 3 },
    attributes = { "passive", "economy", "hands" },
    cost = 5,
    rarity = 2,
    blueprint_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "bof_hooked")
        return {
            vars = {
                numerator,
                denominator
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and BOF.nc(G.consumeables, "cards") then
            for i, fish in ipairs(G.consumeables.cards) do
                if BOF.nc(fish, "ability", "set") == "Fish" and SMODS.pseudorandom_probability(card, "bof_hooked", 1, card.ability.extra.odds) then
                    fish.ability.hooked = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            fish:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize("k_nope_ex"), colour = G.C.SECONDARY_SET.Tarot }, card )
                end
            end
        end
    end
}