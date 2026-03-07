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
            padding = 0.2,
            colour = G.C.BLACK,
        },
        nodes = {
            bundle_toggle("appetizers", G.C.RED),
            bundle_toggle("jesters", G.C.ORANGE),
            bundle_toggle("fables", G.C.BLUE),
            bundle_toggle("normalities", G.C.GREY),
            -- bundle_toggle("flats", G.C.epstein)
        }
    }
end