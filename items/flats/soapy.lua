BundlesOfFun.Back {
	key = "soapy",
    name = "Soapy Deck",
    bundle = "flats",
	atlas = "deck",
	pos = { x = 6, y = 0 },
    unlocked = false,
    calculate = function(self, back, context)
        if context.discard then
            if next(SMODS.get_enhancements(context.other_card)) ~= nil then
                return {
                    remove = true
                }
            end
        end
    end,
    check_for_unlock = function(self, args)
        return args and args.b_bof_soapy
    end
}