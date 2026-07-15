-- create toggle ui element for bundle
local function bundle_toggle(item, colour)
    return { n = G.UIT.R, config = { align = "cm" }, nodes = {
        create_toggle{
            label = localize("option_bof_"..item),
            active_colour = colour,
            col = true,
            label_scale = 0.4,
            ref_table = BundlesOfFun.config.bundles,
            ref_value = item,
            align = "cm"
        }
    }}
end

-- store reference to tab content
G.FUNCS.bof_store_tab_ref = function(e)
    local p = e.parent
    while p do
        if p.config and p.config.object and p.config.object.UIRoot then
            BundlesOfFun.tab_content_box = p
            break
        end
        p = p.parent
    end
    e.config.func = nil
end

-- config tab with... well what do you expect
SMODS.current_mod.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = {
            emboss = 0.05,
            minh = 6,
            r = 0.1,
            minw = 10,
            align = "cm",
            padding = 0.3,
            colour = G.C.BLACK,
        },
        nodes = {
            { n = G.UIT.R, config = { align = "cm", padding = 0.4 }, nodes = {
                create_toggle {
                    label = "Custom Sounds",
                    ref_table = BundlesOfFun.config,
                    ref_value = "custom_sounds",
                },
            }}
        }
    }
end

-- create credit title
local function bof_credit_title(name, role, colour)
    return { n = G.UIT.R, config = { align = "cm", padding = 0.1 }, nodes = {
        { n = G.UIT.T, config = { text = name .. " - " .. role, scale = 0.4, colour = colour, shadow = true } }
    }}
end

-- create credit description
local function bof_credit_description(description)
    return { n = G.UIT.R, config = { align = "cm", padding = 0.05 }, nodes = {
        { n = G.UIT.T, config = { text = description, scale = 0.3, colour = G.C.WHITE, shadow = true } }
    }}
end

-- gradient colors for The Goats
local george = SMODS.Gradient{
    key = "george_the_rat",
    colours = {
        G.C.bof_george_1,
        G.C.bof_george_2
    },
    cycle = 5
}
local glitch = SMODS.Gradient {
    key = "glitchkat10",
    colours = {
        G.C.bof_glitch_1,
        G.C.bof_glitch_2
    },
    cycle = 5
}

-- actually define the tabs for bundles and credits
SMODS.current_mod.extra_tabs = function()
    return {
        {
            label = "Bundles",
            tab_definition_function = function()
                return {
                    n = G.UIT.ROOT,
                    config = {
                        emboss = 0.05,
                        minh = 6,
                        r = 0.1,
                        minw = 10,
                        align = "cm",
                        padding = 0.3,
                        colour = G.C.BLACK,
                    },
                    nodes = {
                        { n = G.UIT.R, config = { align = "cm", padding = 0.2 }, nodes = {
                            { n = G.UIT.C, config = { align = "cm", minw = 5 }, nodes = {
                                bundle_toggle("appetizers", G.C.bof_appetizers),
                                bundle_toggle("jesters", G.C.bof_jesters),
                                bundle_toggle("normalities", G.C.bof_normalities),
                                bundle_toggle("fables", G.C.bof_fables),
                            }},
                            { n = G.UIT.C, config = { align = "cm", minw = 5 }, nodes = {
                                bundle_toggle("flats", G.C.bof_flats),
                                bundle_toggle("fish", G.C.bof_fish),
                                bundle_toggle("coupons", G.C.bof_coupons)
                            }}
                        }},
                        { n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
                            { n = G.UIT.O, config = {
                                object = DynaText({
                                    string = { "Some items only appear if multiple sets are enabled" },
                                    colours = { G.C.WHITE },
                                    scale = 0.4,
                                    shadow = true,
                                    bump = true
                                })
                            } }
                        }},
                        { n = G.UIT.R, config = { func = "bof_store_tab_ref" } },
                    }
                }
            end
        },
        {
            label = "Credits",
            tab_definition_function = function()
                return {
                    n = G.UIT.ROOT,
                    config = {
                        emboss = 0.05,
                        minh = 6,
                        r = 0.1,
                        minw = 10,
                        align = "cm",
                        padding = 0.3,
                        colour = G.C.BLACK,
                    },
                    nodes = {
                        { n = G.UIT.R, config = { align = "cm", padding = 0.3 }, nodes = {
                            { n = G.UIT.O, config = { object = DynaText({
                                string = { { string = "Bundles Of Fun" } },
                                colours = { G.C.GOLD },
                                silent = true,
                                scale = 1.5,
                                shadow = true,
                                emboss = 0.05,
                                float = true,
                                pop_in = 0.1
                            })}}
                        }},
                        { n = G.UIT.R, config = { align = "cm", padding = 0.2 }, nodes = {
                            { n = G.UIT.C, config = { align = "cm", minw = 5 }, nodes = {
                                { n = G.UIT.R, config = { align = "cm", padding = 0.2 }, nodes = {
                                    { n = G.UIT.T, config = { text = "Creators", scale = 0.45, colour = G.C.WHITE, shadow = true } }
                                }},
                                bof_credit_title("George The Rat", "Creator", george),
                                bof_credit_description("All art, most ideas"),
                                bof_credit_title("Glitchkat10", "Co-Creator", glitch),
                                bof_credit_description("Many ideas, nearly all code"),
                            }},
                            { n = G.UIT.C, config = { align = "cm", minw = 5 }, nodes = {
                                { n = G.UIT.R, config = { align = "cm", padding = 0.2 }, nodes = {
                                    { n = G.UIT.T, config = { text = "Contributors", scale = 0.45, colour = G.C.WHITE, shadow = true } }
                                }},
                                bof_credit_title("Amo", "Coder", G.C.HAND_LEVELS[3]),
                                bof_credit_description("Many needed bug fixes"),
                                bof_credit_title("Marffe", "Coder & Localizer", G.C.ORANGE),
                                bof_credit_description("Bug fixes, Spanish translation, many decks"),
                                bof_credit_title("arc", "Musician", G.C.bof_ColonParen),
                                bof_credit_description("Music played in Fish-related packs"),
                                bof_credit_title("wingedcatgirl", "Coder", G.C.SET.Fish),
                                bof_credit_description("Technical code and UI"),
                                bof_credit_title("Sophe", "Coder", G.C.SECONDARY_SET.Enhanced),
                                bof_credit_description("Multiple Decks' code"),
                                bof_credit_title("CodeRevo", "Coder", G.C.STAKES[6]),
                                bof_credit_description("Some Jokers' code"),
                            }}
                        }}
                    }
                }
            end
        }
    }
end


