if not BundlesOfFun then BundlesOfFun = {} end
SMODS.BundlesOfFun = BundlesOfFun

BundlesOfFun.config = SMODS.current_mod.config or {}
BundlesOfFun.config.bundles = BundlesOfFun.config.bundles or {}

BundlesOfFun.mod_config = SMODS.current_mod.config

local lib = {
    "badge",
    "balance",
    "compat",
    "hooks",
    "plural",
    "smods",
    "configui",
}
for _,file in ipairs(lib) do
    assert(SMODS.load_file("lib/"..file..".lua"))()
end

-- function for nil checks on tables - just input a string like "card.ability.extra.whatever" and it'll split it up
function BundlesOfFun.nil_check(path)
    local result = ""
    local current = ""

    for part in path:gmatch("[^%.]+") do
        if current == "" then
            current = part
        else
            current = current .. "." .. part
        end

        if result == "" then
            result = current
        else
            result = result .. " and " .. current
        end
    end

    return result
end

local files = {
    appetizers = {
        list = {
			"dragonfruit",
            "blueberry",
            "grapes",
            "shrimp",
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
    -- normalities = {
    --     list = {
            
    --     }, directory = "items/normalities/"
    -- },
    fables = {
        list = {
            "narr",
            "manqian",
            "turold",
            "taillefer",
            "dagonet"
        }, directory = "items/fables/"
    }
}

for _, category in ipairs({"appetizers", "jesters", "fables"}) do
	local set = files[category]
	for _, name in ipairs(set.list) do
		assert(SMODS.load_file(set.directory .. name .. ".lua"))()
	end
end