BundlesOfFun.Joker {
    key = "billy_bass",
    name = "Big Mouth Billy Bass",
    bundle = { "normalities", { "minnows" } },
    pos = { x = 10, y = 5 },
    attributes = { "retrigger", "fish" },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.retrigger_joker_check and BOF.nc(context.other_context, "joker_main") and BOF.nc(context.other_card, "ability") and context.other_card.ability.set == "Fish" then
            -- on the ninth day of christmas, my true love gave to me
            local nine_ladies_dancing = context.blueprint_card or card
            -- eight_maids_a_milking
            -- seven_swans_a_swimming
            -- six_geese_a_laying
            -- five_gold_rings
            -- four_calling_birds
            -- three_french_hens
            -- two_turtle_doves
            -- and a_partridge_in_a_pear_tree
            return {
                repetitions = 1,
                message = localize("k_again_ex"),
                no_retrigger_juice = true,
                retrigger_juice = nine_ladies_dancing
            }
        end
    end,
    joker_display_def = function()
    end
}