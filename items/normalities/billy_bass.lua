BundlesOfFun.Joker {
    key = "billy_bass",
    name = "Big Mouth Billy Bass",
    bundle = { "normalities", { "minnows" } },
    pos = { x = 9, y = 5 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.retrigger_joker_check and context.other_card and context.other_card.ability.set == "Fish" then
            return {
                repetitions = 1,
                message = localize("k_again_ex"),
                no_retrigger_juice = true,
                retrigger_juice = card
            }
        end
    end
}