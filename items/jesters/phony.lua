BundlesOfFun.Joker {
    key = "phony",
    name = "Phony",
    bundle = "jesters",
    config = {
        extra = {
            mult = 8,
            chips = 10
        },
    },
    pos = { x = 5, y = 2 },
    attributes = { "mult", "chips" },
    cost = 2,
    rarity = 1,
    blueprint_compat = true,
    atlas = BundlesOfFun.config.evil_dih and "evil_dih" or "joker",
    loc_vars = function(self, info_queue, card)
        return {
            key = BundlesOfFun.config.evil_dih and "j_bof_gucci_morty" or "j_bof_phony",
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and hand_chips then
            -- make sure chips do not fall into the negatives
            local chips_to_remove = math.min(card.ability.extra.chips, hand_chips - 1)
            return {
                mult = card.ability.extra.mult,
                chips = -chips_to_remove
            }
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        G.E_MANAGER:add_event(Event({
            func = function()
                if self.discovered and BundlesOfFun.config.evil_dih then
                    card.children.center.atlas = G.ASSET_ATLAS["bof_evil_dih"]
                end
                return true
            end
        }))
	end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "-", colour = G.C.CHIPS },
                { ref_table = "card.ability.extra", ref_value = "chips", colour = G.C.CHIPS },
                { text = " +", colour = G.C.MULT },
                { ref_table = "card.ability.extra", ref_value = "mult", colour = G.C.MULT }
            }
        }
    end
}