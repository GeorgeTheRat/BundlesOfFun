SMODS.Blind {
    key = "prime",
    name = "The Prime",
    bundle = "enemies",
    pos = { y = 0 },
    atlas = "blind",
    boss = { min = 3 },
    boss_colour = HEX("508e76"),
	calculate = function(self, blind, context)
        if not blind.disabled and context.debuff_hand then
            local seal = false
            for k, v in pairs(context.full_hand) do
                if v:get_seal(true) then
                    seal = true
                end
            end
            if seal then
                return {
                    debuff = true
                }
            end
        end
	end,
    get_loc_debuff_text = function(self)
		return localize("bl_bof_prime")
	end
}