local function bundle_toggle(item)
    return create_toggle{
        label = localize("option_bof_"..item),
        ref_table = BundlesOfFun.config.bundles,
        ref_value = item
    }
end

SMODS.current_mod.config_tab = function()
    return {n = G.UIT.ROOT, config = {r = 0.1, minw = 8, minh = 6, align = "tl", padding = 0.2, colour = G.C.BLACK}, nodes = {
        {n = G.UIT.C, config = {minw=1, minh=1, align = "tl", colour = G.C.CLEAR, padding = 0.15}, nodes = {
        bundle_toggle("appetizers"),
        bundle_toggle("jesters"),
        bundle_toggle("fables"),
        bundle_toggle("normalities"),
        --bundle_toggle("jokers"), --Do these actually exist yet?
        --bundle_toggle("geodes")
        }}
    }}
end