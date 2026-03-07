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
            bundle_toggle("appetizers", G.C.bof_appetizers),
            bundle_toggle("jesters", G.C.bof_jesters),
            bundle_toggle("fables", G.C.bof_fables),
            bundle_toggle("normalities", G.C.bof_normalities),
            -- bundle_toggle("flats", G.C.bof_flats),
            -- bundle_toggle("enemies", G.C.bof_enemies),
            -- bundle_toggle("finishers", G.C.bof_finishers),
            -- bundle_toggle("coupons", G.C.bof_coupons),
        }
    }
end