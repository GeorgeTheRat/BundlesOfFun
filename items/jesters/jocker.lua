BundlesOfFun.Joker {
    key = "jocker",
    name = "Jocker",
    bundle = "jesters",
    config = { extra = { dollars = 5 } },
    pos = { x = 7, y = 5 },
    attributes = { "economy" },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.buying_card and (context.card:is_rarity("Common") or context.card:is_rarity("Uncommon")) then
            return {
                dollars = card.ability.extra.dollars
            }
        end
        -- rare doubling logic is located in lovely/jocker.toml
    end
}