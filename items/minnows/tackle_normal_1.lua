BundlesOfFun.Booster {
    key = "tackle_normal_1",
    name = "Tackle Pack",
    bundle = "minnows",
    config = {
        extra = 2,
        choose = 1
    },
    pos = { x = 0, y = 0 },
    attributes = { "booster", "normal", "fish" },
    draw_hand = false,
    group_key = "k_bof_tackle",
    kind = "bof_fish",
    select_card = "consumeables",
    weight = 0.3,
    cost = 4,
    atlas = "pack",
    loc_vars = function(self, info_queue, card)
        local g = SMODS.Booster.loc_vars(self, info_queue, card)
        g.key = self.key:sub(1, -3)
        return g
    end,
    create_card = function(self, card, i)
        if next(SMODS.find_card("j_bof_eureka")) then
            return BundlesOfFun.create_fish_pack_card("fish_b", "bof_fis3", i)
        elseif pseudorandom("p_bof_tackle_jumbo_1") > 0.7 then
            return BundlesOfFun.create_fish_pack_card("fish_b", "bof_fis2", i)
        else
            return BundlesOfFun.create_fish_pack_card("fish_s", "bof_fis1", i)
        end
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.bof_minnows)
        ease_background_colour({
            new_colour = G.C.bof_minnows,
            special_colour = HEX("4f6367"),
            contrast = 2
        })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.175,
            initialize = true,
            lifespan = 0.8,
            speed = 5,
            padding = -2,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.bof_minnows, 0.2), lighten(G.C.bof_minnows, 0.1), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end
}
