local badge_gradient = SMODS.Gradient{
    key = "badge_gradient",
    colours = {
        HEX("8B4A4A"),  -- appetizers (red)
        HEX("4A6A8B"),  -- fables (blue)
        HEX("6B5A7A"),  -- geodes (purple)
        HEX("A3744A"),  -- jesters (orange)
        HEX("7A7A7A")   -- normalities (gray)
    }
}

local TARGET_COLOR = HEX("9363bb")
local original_create_mod_badges = SMODS.create_mod_badges

local CATEGORIES = {
    a = { name = "Appetizers", color_idx = 1 },
    f = { name = "Fables", color_idx = 2 },
    g = { name = "Geodes", color_idx = 3 },
    j = { name = "Jesters", color_idx = 4 },
    n = { name = "Normalities", color_idx = 5 }
}

local function create_category_badge(category_key)
    local category = CATEGORIES[category_key]
    if not category then return nil end
    
    local text = category.name
    local base_scale = 0.3
    local size = 0.9
    
    local font = G.LANG.font
    local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
    local calced_text_width = 0
    for _, c in utf8.chars(text) do
        calced_text_width = calced_text_width + (font.FONT:getWidth(c) * (base_scale) * G.TILESCALE * font.FONTSCALE + 2.7 * 1 * G.TILESCALE * font.FONTSCALE) / (G.TILESIZE * G.TILESCALE)
    end
    local scale_fac = calced_text_width > max_text_width and max_text_width / calced_text_width or 1
    
    return {
        n = G.UIT.R,
        config = { align = "cm", padding = 0.01 },
        nodes = {
            {
                n = G.UIT.R,
                config = {
                    align = "cm",
                    colour = badge_gradient.colours[category.color_idx],
                    r = 0.1,
                    minw = 2.2 / scale_fac,
                    minh = 0.4,
                    emboss = 0.05,
                    padding = 0.03 * 0.9,
                },
                nodes = {
                    { n = G.UIT.B, config = { h = 0.1, w = 0.04 } },
                    {
                        n = G.UIT.O,
                        config = {
                            object = DynaText({
                                string = { { string = text } },
                                colours = { G.C.WHITE },
                                silent = true,
                                float = true,
                                shadow = true,
                                offset_y = -0.03,
                                spacing = 1.1,
                                scale = 0.36 * 0.9 * scale_fac,
                            }),
                        },
                    },
                    { n = G.UIT.B, config = { h = 0.1, w = 0.04 } },
                }
            }
        }
    }
end

function SMODS.create_mod_badges(obj, badges)
    original_create_mod_badges(obj, badges)
    
    if SMODS.config.no_mod_badges then
        return
    end

    local function create_main_badge()
        local text = "Bundles of Fun"
        local base_scale = 0.33 * 0.9
        local size = 0.9
        
        local font = G.LANG.font
        local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
        local calced_text_width = 0
        for _, c in utf8.chars(text) do
            calced_text_width = calced_text_width + (font.FONT:getWidth(c) * base_scale * G.TILESCALE * font.FONTSCALE + 2.7 * 1 * G.TILESCALE * font.FONTSCALE) / (G.TILESIZE * G.TILESCALE)
        end
        local scale_fac = calced_text_width > max_text_width and max_text_width / calced_text_width or 1
        
        return {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = {
                {
                    n = G.UIT.R,
                    config = {
                        align = "cm",
                        colour = badge_gradient,
                        r = 0.1,
                        minw = 2 / scale_fac,
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
                                    string = { { string = text } },
                                    colours = { G.C.WHITE },
                                    silent = true,
                                    float = true,
                                    shadow = true,
                                    offset_y = -0.03,
                                    spacing = 1,
                                    scale = 0.36 * 0.9 * scale_fac,
                                }),
                            },
                        },
                        { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                    },
                },
            },
        }
    end

    for i = 1, #badges do
        local badge = badges[i]
        if badge and badge.nodes and badge.nodes[1] and badge.nodes[1].config then
            local badge_color = badge.nodes[1].config.colour
            if badge_color and 
            badge_color[1] == TARGET_COLOR[1] and 
            badge_color[2] == TARGET_COLOR[2] and 
            badge_color[3] == TARGET_COLOR[3] and
            badge_color[4] == TARGET_COLOR[4] then
            
                if badge.nodes[1].nodes and 
                badge.nodes[1].nodes[2] and 
                badge.nodes[1].nodes[2].config and 
                badge.nodes[1].nodes[2].config.object then
                    badge.nodes[1].nodes[2].config.object:remove()
                end
                
                if obj and obj.key then
                    local category_char = obj.key:match("j_bof_([a-z])_") or obj.key:match("^([a-z])_") or obj.key:sub(1, 1)
                    local category_badge = create_category_badge(category_char)
                    local main_badge = create_main_badge()
                    
                    if category_badge then
                        badges[i] = {
                            n = G.UIT.R,
                            config = { align = "cm", padding = 0.01 },
                            nodes = {
                                category_badge,
                                main_badge
                            }
                        }
                    else
                        badges[i] = main_badge
                    end
                else
                    badges[i] = create_main_badge()
                end
                break
            end
        end
    end
end