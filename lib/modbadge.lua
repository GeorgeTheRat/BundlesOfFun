local badge_gradient = SMODS.Gradient{
    key = "badge_gradient",
    colours = {
        HEX("9363bb"),
        HEX("6376bb")
    }
}

local smcmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	smcmb(obj, badges)
	if not SMODS.config.no_mod_badges then
		local function calc_scale_fac(text)
			local size = 0.9
			local font = G.LANG.font
			local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
			local calced_text_width = 0
			for _, c in utf8.chars(text) do
				calced_text_width = calced_text_width + (font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE + 2.7 * 1 * G.TILESCALE * font.FONTSCALE) / (G.TILESIZE * G.TILESCALE)
			end
			local scale_fac = calced_text_width > max_text_width and max_text_width / calced_text_width or 1
			return scale_fac
		end
        local scale_fac = {}
        local min_scale_fac = 1
        local strings = { "Bundles of Fun" }
        for i = 1, #strings do
            scale_fac[i] = calc_scale_fac(strings[i])
            min_scale_fac = math.min(min_scale_fac, scale_fac[i])
        end
        local ct = {}
        for i = 1, #strings do
            ct[i] = {
                string = strings[i],
            }
        end
        local bof_badge = {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = {
                {
                    n = G.UIT.R,
                    config = {
                        align = "cm",
                        colour = badge_gradient,
                        r = 0.1,
                        minw = 2 / min_scale_fac,
                        minh = 0.36,
                        emboss = 0.05,
                        padding = 0.03 * 0.9,
                    },
                    nodes = {
                        { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                        {
                            n = G.UIT.O,
                            config = {
                                object = DynaText({
                                    string = ct or "ERROR",
                                    colours = { G.C.WHITE },
                                    silent = true,
                                    float = true,
                                    shadow = true,
                                    offset_y = -0.03,
                                    spacing = 1,
                                    scale = 0.33 * 0.9,
                                }),
                            },
                        },
                        { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                    },
                },
            },
        }
        local function eq_col(x, y)
            for i = 1, 4 do
                if x[i] ~= y[i] then
                    return false
                end
            end
            return true
        end
        for i = 1, #badges do
            if eq_col(badges[i].nodes[1].config.colour, HEX("9363bb")) then
                badges[i].nodes[1].nodes[2].config.object:remove()
                badges[i] = bof_badge
                break
            end
        end
	end
end