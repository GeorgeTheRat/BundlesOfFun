-- on entering the blind, give the leftmost joker a random sticker permanently
BundlesOfFun.Blind {
    key = "irrational",
    name = "The Irrational",
    bundle = "enemies",
    pos = { y = 15 },
    attributes = { "position", "stickers" },
    atlas = "blind",
    boss = { min = 3 },
    boss_colour = HEX("d8d888"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.setting_blind then
            local target = BOF.nc(G.jokers, "cards", 1)
            if not target then return end

            local available_stickers = {}
            for k, v in pairs(SMODS.Stickers) do
                local compat = v.original_mod and type(v.should_apply) == "function"
                    and v:should_apply(target, target.config.center, target.area, true)
                    or target.config.center[v.key .. "_compat"] ~= false
                local already_has = v.key == "pinned" and target.pinned or target.ability[v.key]
                if compat and not already_has and k ~= "tmj_pinned" then
                    table.insert(available_stickers, v)
                end
            end

            if #available_stickers > 0 then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        local sticker = pseudorandom_element(available_stickers, pseudoseed("bof_irrational_sticker"))
                        target:add_sticker(sticker.key, true)
                        target:juice_up()
                        return true
                    end
                }))
                return { message = localize("k_sticker_ex") }
            end
        end
    end
}