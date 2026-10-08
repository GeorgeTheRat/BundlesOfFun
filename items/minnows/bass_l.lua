BundlesOfFun.Consumable {
    key = "bass_l",
    name = "Largemouth Bass Legendary",
    bundle = "minnows",
    set = "Fish",
    soul_set = "Fish",
    pools = { ["fish_l"] = true },
    pos = { x = 0, y = 2 },
    attributes = { "chips" },
    config = {
        card_limit = 1,
        extra = { consumable_slots = 0 }
    },
    cost = 20,
    unlocked = false,
    hidden = true,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.card_limit } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local total_chips = 0
            for i, c in ipairs(G.playing_cards or {}) do
                if c:get_id() ~= 14 and not c:is_face() then
                    total_chips = total_chips + c:get_chip_bonus()
                    if BOF.nc(c.ability, "perma_bonus") then
                        total_chips = total_chips + c.ability.perma_bonus
                    end
                end
            end
            return {
                chips = total_chips
            }
        end
    end
}