BundlesOfFun.Back {
	key = "fossilized",
    name = "Fossilized Deck",
    bundle = "flats",
    config = { dollars_per_consumable = 1 },
	atlas = "deck",
	pos = { x = 9, y = 0 },
    unlocked = false,
    loc_vars = function(self, info_queue)
		return { vars = { self.config.dollars_per_consumable } }
	end,
    calc_dollar_bonus = function(self, back)
        local count = 0
        if G.consumeables and G.consumeables.cards then
            for _, c in ipairs(G.consumeables.cards) do
                if c.ability and c.ability.consumeable then
                    count = count + 1
                end
            end
        end
        if count > 0 then
            return count * self.config.dollars_per_consumable
        end
    end,
    check_for_unlock = function(self, args)
        if G.consumeables and G.consumeables.cards then
            local has = { Tarot = false, Planet = false, Spectral = false }
            for _, c in ipairs(G.consumeables.cards) do
                local set = c.ability and c.ability.set
                if set and has[set] ~= nil then
                    has[set] = true
                end
            end
            if has.Tarot and has.Planet and has.Spectral then
                return true
            end
        end
    end,
    calculate = function(self, back, context)
        if context.create_shop_card and (context.set == "Tarot" or context.set == "Planet" or context.set == "Spectral" or context.set == "Fish") then
            if not G.GAME.used_vouchers["v_bof_illegal_wares"] then
                if pseudorandom(pseudoseed("bof_fossilized")) < 0.06 then
                    return { shop_create_flags = { edition = "e_negative" } }
                end
            end
        end
    end
}