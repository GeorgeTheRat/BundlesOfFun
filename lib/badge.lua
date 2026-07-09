-- gradient for mod badge using bundle colors
local badge_gradient = SMODS.Gradient{
    key = "badge_gradient",
    colours = {
        G.C.bof_appetizers,
        G.C.bof_jesters,
        G.C.bof_normalities,
        G.C.bof_fables,
        G.C.bof_flats,
        G.C.bof_fish,
        G.C.bof_coupons
    }
}

local original_create_mod_badges = SMODS.create_mod_badges

-- bundle category names and gradient color indices
-- i'm smart i know that word
-- pneumonoultramicroscopicsilicovolcanoconiosis
local CATEGORIES = {
    appetizers = { name = "Appetizers", color_idx = 1 },
    jesters = { name = "Jesters", color_idx = 2 },
    normalities = { name = "Normalities", color_idx = 3 },
    fables = { name = "Fables", color_idx = 4 },
    flats = { name = "Flats", color_idx = 5 },
    fish = { name = "Fish", color_idx = 6 },
    coupons = { name = "Coupons", color_idx = 7 }
}

-- calculate text scaling to fit badge width
local function create_category_badge(category_key, shared_scale_fac)
    local category = CATEGORIES[category_key]
    if not category then return nil end
    
    local text = category.name
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
        config = { align = "cm", padding = 0.01 },
        nodes = {
            {
                n = G.UIT.R,
                config = {
                    align = "cm",
                    colour = badge_gradient.colours[category.color_idx],
                    r = 0.1,
                    minw = 2 / shared_scale_fac,
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
                }
            }
        }
    }
end

function SMODS.create_mod_badges(obj, badges)
    if SMODS.config.no_mod_badges then
        return
    end

    if obj and obj.set == "Back" and obj.unlocked == false then
        return
    end

    -- calculate scale factor for text to fit badge
    local function calculate_scale_fac(text)
        local base_scale = 0.33 * 0.9
        local size = 0.9
        local font = G.LANG.font
        local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
        local calced_text_width = 0
        for _, c in utf8.chars(text) do
            calced_text_width = calced_text_width + (font.FONT:getWidth(c) * base_scale * G.TILESCALE * font.FONTSCALE + 2.7 * 1 * G.TILESCALE * font.FONTSCALE) / (G.TILESIZE * G.TILESCALE)
        end
        return calced_text_width > max_text_width and max_text_width / calced_text_width or 1
    end

    -- create main mod badge with gradient
    local function create_main_badge(shared_scale_fac)
        local text = "Bundles Of Fun"
        local scale_fac = calculate_scale_fac(text)
        
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
                        minw = 2 / shared_scale_fac,
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

    if obj and obj.bundle then
        local category_name
        if type(obj.bundle) == "string" then
            category_name = obj.bundle
        elseif type(obj.bundle) == "table" then
            category_name = obj.bundle[1]
        end
        
        local category = CATEGORIES[category_name]
        if category then
            local main_scale_fac = calculate_scale_fac("Bundles Of Fun")
            local category_scale_fac = calculate_scale_fac(category.name)
            local shared_scale_fac = math.min(main_scale_fac, category_scale_fac)
            
            local category_badge = create_category_badge(category_name, shared_scale_fac)
            local main_badge = create_main_badge(shared_scale_fac)
            
            if category_badge then
                badges[#badges + 1] = {
                    n = G.UIT.R,
                    config = { align = "cm", padding = 0.01 },
                    nodes = {
                        category_badge,
                        main_badge
                    }
                }
            else
                badges[#badges + 1] = main_badge
            end
        else
            badges[#badges + 1] = create_main_badge(calculate_scale_fac("Bundles Of Fun"))
        end
    else
        original_create_mod_badges(obj, badges)
    end
end