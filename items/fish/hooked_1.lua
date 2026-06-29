BundlesOfFun.Booster {
    key = "hooked_1",
    name = "Hooked Pack",
    bundle = "fish",
    config = {
        extra = 2,
        choose = 1
    },
    pos = { x = 2, y = 1 },
    draw_hand = false,
    group_key = "k_bof_hooked",
    kind = "bof_fish",
    select_card = "consumeables",
    weight = 0.3,
    cost = 8,
    atlas = "pack",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra
            },
            key = self.key:sub(1, -3)
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "fish_b",
            skip_materialize = true,
            area = G.pack_cards,
            soulable = true,
            key_append = "bof_fis"
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.bof_fish)
        ease_background_colour({
            new_colour = G.C.bof_fish,
            special_colour = HEX("4f6367"),
            contrast = 2
        })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.bof_fish, 0.4), lighten(G.C.bof_fish, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end
}