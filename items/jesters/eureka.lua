local function add_eureka_booster(card, context)
    -- on the fifth day of christmas, my true love gave to me
    local five_gold_rings = context.blueprint_card or card
    -- four_calling_birds
    -- three_french_hens
    -- two_turtle_doves
    -- and a_partridge_in_a_pear_tree
    if (not G.shop or not BOF.nc(G.shop_booster, "cards")) or five_gold_rings.ability.bof_eureka_shop_round == G.GAME.round then return end
    local mega_pool = {}
    for _, key in ipairs(SMODS.get_attribute_pool("mega")) do
        local center = G.P_CENTERS[key]
        if BOF.nc(center, "set") == "Booster" and not BOF.nc(G.GAME.banned_keys, key) then
            mega_pool[#mega_pool + 1] = key
        end
    end
    local key = pseudorandom_element(mega_pool, pseudoseed("bof_eureka"))
    local booster, used_packs = SMODS.add_booster_to_shop(key), G.GAME.current_round.used_packs or {}
    booster.ability.couponed = true
    booster:set_cost()
    G.GAME.current_round.used_packs = used_packs
    local booster_pos = #used_packs + 1
    booster.ability.booster_pos = booster_pos
    booster.ability.bof_eureka_owner_id = five_gold_rings.ID
    used_packs[booster_pos] = key
    five_gold_rings.ability.bof_eureka_shop_round = G.GAME.round
    five_gold_rings:juice_up(0.3, 0.5)
end

BundlesOfFun.Joker {
    key = "eureka",
    name = "Emmanuel E. \"Eureka\"",
    bundle = "jesters",
    pos = { x = 8, y = 1 },
    attributes = { "booster", "shop" },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.starting_shop then
            add_eureka_booster(card, context)
        end
    end,
    joker_display_def = function(JokerDisplay)
    end
}