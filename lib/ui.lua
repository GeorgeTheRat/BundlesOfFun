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
            }},
            { n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
                create_toggle {
                    label = "Custom Wooden Deck Texture",
                    ref_table = BundlesOfFun.config,
                    ref_value = "custom_wooden_center",
                },
            }},
            { n = G.UIT.R, config = { align = "cm" }, nodes = {
                { n = G.UIT.T, config = { text = "(Requires a restart)", scale = 0.25, colour = G.C.WHITE, shadow = true } }
            }}
        }
    }
end

local function bof_credit_title(name, role, colour)
    return { n = G.UIT.R, config = { align = "cm", padding = 0.1 }, nodes = {
        { n = G.UIT.T, config = { text = name .. " - " .. role, scale = 0.5, colour = colour, shadow = true } }
    }}
end

local function bof_credit_description(description)
    return { n = G.UIT.R, config = { align = "cm", padding = 0.05 }, nodes = {
        { n = G.UIT.T, config = { text = description, scale = 0.35, colour = G.C.WHITE, shadow = true } }
    }}
end

george = SMODS.Gradient{
    key = "george_the_rat",
    colours = {
        G.C.bof_george_1,
        G.C.bof_george_2
    },
    cycle = 5
}
glitch = SMODS.Gradient {
    key = "glitchkat10",
    colours = {
        G.C.bof_glitch_1,
        G.C.bof_glitch_2
    },
    cycle = 5
}

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
                        { n = G.UIT.R, config = { align = "cm" }, nodes = {
                            { n = G.UIT.O, config = { object = DynaText({
                                string = { "WARNING" },
                                colours = { SMODS.Gradients.warning_text },
                                scale = 1,
                                shadow = true,
                                emboss = 0.05,
                                bump = true
                            })}}
                        }},
                        { n = G.UIT.R, config = { align = "cm" }, nodes = {
                            { n = G.UIT.T, config = { text = "Continuing a run after disabling a set may crash the game!", scale = 0.4, colour = G.C.RED, shadow = true } }
                        }},
                        { n = G.UIT.R, config = { align = "cm", padding = 0.2 }, nodes = {
                            { n = G.UIT.C, config = { align = "cm", minw = 5 }, nodes = {
                                bundle_toggle("appetizers", G.C.bof_appetizers),
                                bundle_toggle("jesters", G.C.bof_jesters),
                                bundle_toggle("normalities", G.C.bof_normalities),
                            }},
                            { n = G.UIT.C, config = { align = "cm", minw = 5 }, nodes = {
                                bundle_toggle("fables", G.C.bof_fables),
                                bundle_toggle("flats", G.C.bof_flats),
                                bundle_toggle("fish", G.C.SET.Fish),
                            }}
                        }},
                        { n = G.UIT.R, config = { align = "cm" }, nodes = {
                            { n = G.UIT.T, config = { text = "Changes require a restart", scale = 0.5, colour = G.C.WHITE, shadow = true } }
                        }},
                        { n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
                            { n = G.UIT.T, config = { text = "(Some items only appear if multiple sets are enabled)", scale = 0.3, colour = G.C.WHITE, shadow = true } }
                        }},
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
                                bof_credit_title("Marffe", "Coder & Localizer", G.C.ORANGE),
                                bof_credit_description("Bug fixes, Spanish translation, many decks"),
                                bof_credit_title("wingedcatgirl", "Coder", G.C.SET.Fish),
                                bof_credit_description("Technical code and UI"),
                                bof_credit_title("CodeRevo", "Coder", G.C.STAKES[6]),
                                bof_credit_description("Some Jokers' code"),
                                bof_credit_title("Sophe", "Coder", G.C.SECONDARY_SET.Enhanced),
                                bof_credit_description("Lightning Deck"),
                            }}
                        }}
                    }
                }
            end
        }
    }
end


