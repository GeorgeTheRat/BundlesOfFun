SMODS.Joker({
	key = "j_polymath",
	name = "Polymath",
	config = {
		extra = {
			odds = 5,

			smult = 2,
			schips = 10,
			sxchips = 1.2,
			sbalance = 5,
			sdollars = 1,

			fchips = 1,
		},
	},
	pos = { x = 6, y = 2 },
	rarity = 3,
	order = 27,
	blueprint_compat = true,
	atlas = "joker",
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
        local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "seed")
		return {
			vars = {
				num,
                den,
				cae.smult,
				cae.schips,
				cae.sxchips,
				cae.sbalance,
				cae.sdollars,
				cae.fchips,
                colours = { { 0.8, 0.45, 0.85, 1 } }
			},
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.individual and (context.cardarea == G.play or context.cardarea == G.hand) and not context.end_of_round then
            if SMODS.pseudorandom_probability(card,"seed",1,cae.odds) then
                return{
                    chips = cae.schips,
                    mult = cae.smult,
                    xchips = cae.sxchips,
                    dollarsa = cae.sdollars,
                    bof_balance_percent = cae.sbalance * 0.01
                }
            else
                return{
                    chips = -cae.fchips
                }
            end
		end
	end,
    in_pool = function(self, args)
        if G.GAME then
            if G.GAME.selected_back.effect.center.key ~= "b_plasma" then
                return true
            end
        end
        return false
    end
})
