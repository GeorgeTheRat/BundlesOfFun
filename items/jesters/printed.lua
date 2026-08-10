BundlesOfFun.Joker {
    key = "printed",
    name = "3D-Printed Joker",
    bundle = "jesters",
    pos = { x = 0, y = 6 },
    attributes = { "mult", "chips" },
    cost = 10,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        local effects = {}
        for _, other_joker in ipairs(G.jokers.cards) do
            if other_joker ~= card and other_joker:is_rarity(1) then
                local effect = SMODS.blueprint_effect(card, other_joker, context)
                if effect then
                    table.insert(effects, { effect })
                end
            end
        end
        if #effects > 0 then
            local ret = SMODS.merge_effects(unpack(effects))
            ret.colour = G.C.PURPLE
            return ret
        end
    end
}