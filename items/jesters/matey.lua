BundlesOfFun.Joker {
    key = "matey",
    name = "Matey",
    bundle = { "jesters", { "fish" } },
    pos = { x = 6, y = 6 },
    attributes = { "passive", "fish" },
    cost = 6,
    rarity = 1,
    blueprint_compat = false,
    atlas = "joker",
    set_ability = function(self, card, initial, delay_sprites)
        G.E_MANAGER:add_event(Event({
            func = function()
                if self.discovered and not BOF.nc(card.area, "config", "collection") and pseudorandom("bof_matey") > 0.9 then
                    card.children.center.atlas = G.ASSET_ATLAS["bof_evil_dih"]
                end
                return true
            end
        }))
	end
}