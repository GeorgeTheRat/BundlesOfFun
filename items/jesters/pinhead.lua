BundlesOfFun.Joker {
    key = "pinhead",
    name = "Pinhead",
    bundle = "jesters",
    pos = { x = 9, y = 4 },
    attributes = { "mult", "hand_type" },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local idx = 0
            for i, v in ipairs(context.full_hand) do
                if v == context.other_card then idx = i break end
            end
            local triggers = false
            if idx > 1 then
                local adjacent = context.full_hand[idx - 1]
                if BOF.nc(adjacent, "ability", "name") and (adjacent.ability.name == "Bonus" or adjacent.ability.name == "Mult") then
                    triggers = true
                end
            end
            if idx < #context.full_hand then
                local adjacent = context.full_hand[idx + 1]
                if BOF.nc(adjacent, "ability", "name") and (adjacent.ability.name == "Bonus" or adjacent.ability.name == "Mult") then
                    triggers = true
                end
            end
            if triggers then
                return {
                    repetitions = 1
                }
            end
        end
    end
}