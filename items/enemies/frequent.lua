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
            if not SMODS.has_no_suit(context.other_card) and context.other_card.base.suit == frequent_suit then
                return {
                    stay_flipped = true
                }
            end
        end
    end,
    loc_vars = function(self)
        local active_frequent = BOF.nc(G.GAME, "blind", "config", "blind", "key") == "bl_bof_frequent"
        local suit = active_frequent and BOF.nc(G.GAME, "bof_frequent_suit") or BundlesOfFun.get_frequent_suit()
        return { vars = { localize(suit, "suits_singular") } }
    end,
    collection_loc_vars = function(self)
        return { vars = { localize("bof_most_common_suit") } }
    end
}