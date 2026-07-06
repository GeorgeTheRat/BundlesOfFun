-- initialize mod namespace and config
if not BundlesOfFun then BundlesOfFun = {} end
SMODS.BundlesOfFun = BundlesOfFun

BundlesOfFun.config = SMODS.current_mod.config or {}
BundlesOfFun.config.bundles = BundlesOfFun.config.bundles or {}
BundlesOfFun.config.custom_sounds = BundlesOfFun.config.custom_sounds or {}

BundlesOfFun.mod_config = SMODS.current_mod.config

-- define custom colors for all the stuffs
G.C.bof_appetizers = HEX("bb463c")
G.C.bof_jesters = HEX("ffc857")
G.C.bof_fables = HEX("535fc1")
G.C.bof_normalities = HEX("c4bca5")
G.C.bof_flats = HEX("ff7a6f")
G.C.bof_fish = { 1.0, 0.6, 0.7, 1 }
G.C.bof_coupons = HEX("69aad8")
G.C.bof_enemies = HEX("626e7a")
G.C.bof_finishers = HEX("49564c")
G.C.bof_george_1 = HEX("67bf9d")
G.C.bof_george_2 = HEX("1e9ae9")
G.C.bof_glitch_1 = HEX("f04360")
G.C.bof_glitch_2 = HEX("855a82")
G.C.bof_ColonParen = HEX("3498db")
G.C.PLASMA = { 0.8, 0.45, 0.85, 1 }

-- register localization colors
loc_colour()
G.ARGS.LOC_COLOURS.plasma = { 0.8, 0.45, 0.85, 1 }
G.ARGS.LOC_COLOURS.small = mix_colours(G.C.BLUE, G.C.BLACK, 0.6)
G.ARGS.LOC_COLOURS.big = mix_colours(G.C.ORANGE, G.C.BLACK, 0.6)

-- load all library files
local files = NFS.getDirectoryItemsInfo(SMODS.current_mod.path .. "/lib")
for i = 1, #files do
    local file_name = files[i].name
    if file_name:sub(-4) == ".lua" then
        assert(SMODS.load_file("lib/" .. file_name))()
    end
end

-- define bundle structure and item lists
-- this replaces "order" from many other mods
local files = {
    appetizers = {
        list = {
			"dragonfruit",
            "blueberry",
            "grapes",
            "leek",
            "durian",
            "bread",
            "beans",
            "apple",
            "core",
            "tomato",
            "shrimp"
		}, directory = "items/appetizers/"
    },
    jesters = {
        list = {
            "hal",
            "henry",
            "tom",
            "barber",
            "ballbo",
            "rogue",
            "eddrick",
            "super",
            "eureka",
            "timmy",
            "gary",
            "golden_sun",
            "jack_frost",
            "jim",
            "gumphrey",
            "soothsayer",
            "polymath",
            "luminary",
            "felix",
            "larry",
            "phony",
            "frank",
            "crafted",
            "schlitzohr",
            "hotboxer",
            "director",
            "zeke",
            "laughing_stock",
            "angler",
            "pianoman"
        }, directory = "items/jesters/"
    },
    normalities = {
        list = {
            "notebook",
            "eraser",
            "rummikub",
            "passport",
            "clock",
        }, directory = "items/normalities/"
    },
    fables = {
        list = {
            "narr",
            "manqian",
            "turold",
            "taillefer",
            "dagonet",
            "shennong",
            "nuwa_fuxi"
        }, directory = "items/fables/"
    },
    flats = {
        list = {
            "embroidered",
            "flannel",
            "illusion",
            "fossilized",
            "wooden",
            "backgammon",
            "retro",
            "soapy",
            "display",
            "lightning"
        }, directory = "items/flats/"
    },
    fish = {
        list = {
            "bass_s",
            "betta_s",
            "trout_s",
            "goldfish_s",
            "bass_b",
            "betta_b",
            "trout_b",
            "goldfish_b",
            "bass_l",
            "betta_l",
            "trout_l",
            "goldfish_l",
            "tackle_normal_1",
            "tackle_normal_2",
            "tackle_jumbo_1",
            "tackle_jumbo_2",
            "fry_1",
            "fry_2",
            "hooked_1",
            "hooked_2"
        }, directory = "items/fish/"
    },
    coupons = {
        list = {
            "dark_alley",

    --         "illegal_wares",
    --         "unboxing",
    --         "scalping",
    --         "lottery_ticket",
                "scratch_off",
                "ice_bucket",
                "buried_treasure"
        }, directory = "items/coupons/"
    }
}

-- load all bundle items
for _, name in ipairs(files["appetizers"].list) do
    assert(SMODS.load_file(files["appetizers"].directory .. name .. ".lua"))()
end

for _, name in ipairs(files["jesters"].list) do
    assert(SMODS.load_file(files["jesters"].directory .. name .. ".lua"))()
end

for _, name in ipairs(files["normalities"].list) do
    assert(SMODS.load_file(files["normalities"].directory .. name .. ".lua"))()
end

for _, name in ipairs(files["fables"].list) do
    assert(SMODS.load_file(files["fables"].directory .. name .. ".lua"))()
end

for _, name in ipairs(files["flats"].list) do
    assert(SMODS.load_file(files["flats"].directory .. name .. ".lua"))()
end

for _, name in ipairs(files["fish"].list) do
    assert(SMODS.load_file(files["fish"].directory .. name .. ".lua"))()
end

for _, name in ipairs(files["coupons"].list) do
    assert(SMODS.load_file(files["coupons"].directory .. name .. ".lua"))()
end
