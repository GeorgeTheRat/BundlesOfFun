-- Took me like 40 rerolls before getting a negative consumable xd
SMODS.Back {
	key = "l_fossilized",
    name = "Fossilized Deck",
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
                unlock_card(self)
                return true
            end
        end
        return false
    end
}
