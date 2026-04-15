if not BundlesOfFun then BundlesOfFun = {} end
SMODS.BundlesOfFun = BundlesOfFun

BundlesOfFun.config = SMODS.current_mod.config or {}
BundlesOfFun.config.bundles = BundlesOfFun.config.bundles or {}

BundlesOfFun.mod_config = SMODS.current_mod.config

G.C.bof_appetizers = HEX("bb463c")
G.C.bof_jesters = HEX("ffc857")
G.C.bof_fables = HEX("535fc1")
G.C.bof_normalities = HEX("c4bca5")
G.C.bof_flats = HEX("ff7a6f")
G.C.bof_enemies = HEX("626e7a")
G.C.bof_finishers = HEX("49564c")
G.C.bof_coupons = HEX("a0cff1")
G.C.PLASMA = { 0.8, 0.45, 0.85, 1 }

loc_colour()
G.ARGS.LOC_COLOURS.plasma = { 0.8, 0.45, 0.85, 1 }
G.ARGS.LOC_COLOURS.small = HEX("3a55ab")
G.ARGS.LOC_COLOURS.big = HEX("e0a23a")

local files = NFS.getDirectoryItemsInfo(SMODS.current_mod.path .. "/lib")
for i = 1, #files do
    local file_name = files[i].name
    if file_name:sub(-4) == ".lua" then
        assert(SMODS.load_file("lib/" .. file_name))()
    end
end

local files = {
    appetizers = {
        list = {
			"dragonfruit",
            "blueberry",
            "grapes",
            "leek",
            "durian",
            "wonderous_bread",
            "jelly_beans",
            "apple",
            "apple_core",
            "tomato"
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
            "furious",
            "larry",
            "phony",
            "frank",
            "crafted",
            "schlitzohr",
            "hotboxer"
        }, directory = "items/jesters/"
    },
    normalities = {
        list = {
            "notebook",
            "eraser",
            "rummikub",
            "passport",
            "alarm_clock",
        }, directory = "items/normalities/"
    },
    fables = {
        list = {
            "narr",
            "manqian",
            "turold",
            "taillefer",
            "dagonet"
        }, directory = "items/fables/"
    },
    flats = {
        list = {
            -- "embroidered",
            "flannel",
            "illusion",
            -- "fossilized",
            "wooden",
            -- "backgammon",
            -- "retro",
            "soapy",
            -- "display",
            -- "lightning"
        }, directory = "items/flats/"
    },
    -- coupons = {
    --     list = {
    --         "dark_alley",
    --         "illegal_wares",
    --         "unboxing",
    --         "scalping",
    --         "dumpster_diving",
    --         "raccoon_tactics",
    --         "scratch_off",
    --         "lottery_ticket",
    --         "phishing",
    --         "social_engineering"
    --     }, directory = "items/vouchers/"
    -- }
}

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

-- for _, name in ipairs(files["coupons"].list) do
--     assert(SMODS.load_file(files["coupons"].directory .. name .. ".lua"))()
-- end