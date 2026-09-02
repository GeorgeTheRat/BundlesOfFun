BundlesOfFun.Joker {
    key = "doctor",
    name = "Doctor",
    bundle = "jesters",
    pos = { x = 0, y = 3 },
    attributes = { "generation" },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.setting_ability and context.other_card and context.new and context.new ~= "Base" and not context.unchanged then
            local rarity = 4
            while rarity == 3 or rarity == 4 do
                rarity = SMODS.poll_rarity("Joker", "bof_doctor")
            end
            if type(rarity) == "number" and rarity > 0 and rarity < 3 then
                local rarity_names = { [1] = "Common", [2] = "Uncommon" }
                rarity = rarity_names[rarity]
            end
            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        local new_card = SMODS.add_card {
                            set = "Joker",
                            rarity = rarity,
                            key_append = "bof_doctor"
                        }
                        new_card:start_materialize()
                        G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return {
                    message = localize("k_plus_joker"),
                    colour = G.C.RARITY[rarity] or G.C.FILTER
                }
            end
        end
    end,
    joker_display_def = function(JokerDisplay)
    end
}