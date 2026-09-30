-- cards of the most common suit are drawn face down
BundlesOfFun.Blind {
    key = "frequent",
    name = "The Frequent",
    bundle = "enemies",
    pos = { y = 12 },
    attributes = { "suit", "face_down" },
    atlas = "blind",
    boss = { min = 3 },
    boss_colour = HEX("98a868"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        local frequent_suit = BOF.nc(G.GAME, "bof_frequent_suit")
        if context.stay_flipped and context.to_area == G.hand and frequent_suit then
            if context.other_card.base.suit == frequent_suit then
                return {
                    stay_flipped = true
                }
            end
        end
    end,
    loc_vars = function(self)
        local suit = BOF.nc(G.GAME, "bof_frequent_suit")
        if suit then
            return { vars = { localize(suit, "suits_singular") } }
        end
        return { vars = { "" } }
    end,
    collection_loc_vars = function(self)
        return { vars = { localize("bof_most_common_suit") } }
    end
}