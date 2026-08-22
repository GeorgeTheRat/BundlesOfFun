SMODS.Atlas({
    key = "credit", 
    path = "credit.png", 
    px = 68,
    py = 68, 
})

SMODS.Atlas({
    key = "placeholder", 
    path = "placeholder.png", 
    px = 71,
    py = 95, 
})

SMODS.Atlas({
    key = "joker", 
    path = "joker.png", 
    px = 71,
    py = 95, 
})

SMODS.Atlas({
    key = "hal", 
    path = "hal.png", 
    px = 71,
    py = 95, 
})

SMODS.Atlas({
    key = "deck", 
    path = "deck.png", 
    px = 71,
    py = 95, 
})

SMODS.Atlas({
    key = "wooden", 
    path = "wooden.png", 
    px = 71,
    py = 95, 
})

SMODS.Atlas({
    key = "consumable", 
    path = "consumable.png", 
    px = 71,
    py = 95,
})

SMODS.Atlas({
    key = "fish_blank", 
    path = "fish_blank.png", 
    px = 71,
    py = 95,
})

SMODS.Atlas({
    key = "pack", 
    path = "pack.png", 
    px = 71,
    py = 95,
})

SMODS.Atlas({
    key = "voucher", 
    path = "voucher.png", 
    px = 71,
    py = 95,
})

SMODS.Atlas {
	key = "blind",
    atlas_table = "ANIMATION_ATLAS",
	path = "blind.png",
	px = 34,
	py = 34,
	frames = 21
}

SMODS.Atlas({
    key = "pinned",
    path = "pinned.png",
    px = 71,
    py = 95,
})

-- Steamodded already registers "pinned" as a real Sticker (it's what backs vanilla's
-- card.pinned), just pointed at an out-of-bounds placeholder position since the base
-- game has no art for it - point it at ours instead. This is enough for
-- SMODS.Sticker's own inject() to build the sprite into G.shared_stickers.pinned.
SMODS.Sticker:take_ownership("pinned", {
    atlas = "pinned",
    pos = { x = 0, y = 0 },
})

-- Steamodded replaces Card:draw entirely with SMODS.DrawSteps, and its own built-in
-- 'stickers' step (order 40) only draws stickers stored in card.ability[key] - but
-- "pinned"'s apply sets the top-level card.pinned field instead, so it's skipped by
-- that generic loop too. A dedicated step, checking the right field, is needed.
SMODS.DrawStep {
    key = "bof_pinned",
    order = 41,
    func = function(self, layer)
        if self.pinned and G.shared_stickers.pinned then
            G.shared_stickers.pinned.role.draw_major = self
            G.shared_stickers.pinned:draw_shader('dissolve', nil, nil, nil, self.children.center)
            G.shared_stickers.pinned:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

-- for jokers that scale its scaling effect
SMODS.Attribute({
    key = "scale_scaling"
})

-- for jokers that adjust consumable slots (just tumor tom rn)
SMODS.Attribute({
    key = "consumable_slot"
})

-- for jokers that do stuff with fish
SMODS.Attribute({
    key = "fish"
})

-- for jokers that do stuff with stickers (just notebook)
SMODS.Attribute({
    key = "stickers"
})

-- fih
SMODS.ConsumableType({
    key = "Fish",
    primary_colour = { 1.0, 0.6, 0.7, 1 },
    secondary_colour = { 1.0, 0.6, 0.7, 1 },
    collection_rows = { 2, 2 },
    shop_rate = 0,
    select_card = "consumeables",
    default = "c_bof_bass_s",
    loc_txt = {
        undiscovered = {
            name = "Not Discovered",
            text = {
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
            }
        }
    }
})

-- cool dynatext i made for fun that serves no purpose other than being cool
SMODS.DynaTextEffect {
    key = "alarm",
    func = function(dynatext, index, letter)
        letter.offset.x = math.sin((G.TIMERS.REAL + index)*(40 + index*5)) * 3
        letter.offset.y = math.cos((G.TIMERS.REAL + index)*(45 + index*5)) * 3
        letter.r = math.sin((G.TIMERS.REAL + index)*(25 + index*3)) * 0.1
    end
}

-- small fish
SMODS.ObjectType({
    key = "fish_s",
    select_card = "consumeables",
    default = "c_bof_bass_s",
})

-- big fish
SMODS.ObjectType({
    key = "fish_b",
    select_card = "consumeables",
    default = "c_bof_bass_b"
})

-- legendary fish
SMODS.ObjectType({
    key = "fish_l",
    select_card = "consumeables",
    default = "c_bof_bass_l"
})

SMODS.Sound({
	key = "wooden_1",
	path = "wooden_1.ogg",
	loop = false
})

SMODS.Sound({
	key = "wooden_2",
	path = "wooden_2.ogg",
	loop = false
})

SMODS.Sound({
	key = "wooden_3",
	path = "wooden_3.ogg",
	loop = false
})

SMODS.Sound({
	key = "wooden_4",
	path = "wooden_4.ogg",
	loop = false
})

SMODS.Sound({
	key = "alarm_ring",
	path = "alarm_ring.ogg",
	loop = false
})

SMODS.Sound({
    key = "music_fish",
    path = "music_fish.ogg",
    select_music_track = function()
        -- why does this need this many checks
        return G.booster_pack and not G.booster_pack.REMOVED and SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.config.center.kind == "bof_fish" and 100 or nil
    end
})

-- ts was NOT the wind
SMODS.Sound({
	key = "alarm_wind",
	path = "alarm_wind.ogg",
	loop = false
})

SMODS.UndiscoveredSprite({
    key = "Fish",
    atlas = "fish_blank",
    pos = { x = 0, y = 0 }
})

-- check for some deck unlocks
SMODS.current_mod.calculate = function(self, context)
    if context.end_of_round and context.main_eval then
        G.GAME.current_round.bof_wooden_destroyed = 0
    end
    if context.remove_playing_cards then
        -- wooden deck
        G.GAME.current_round.bof_wooden_destroyed = G.GAME.current_round.bof_wooden_destroyed or 0
        for k, v in pairs(context.removed or {}) do
            if v:get_id() == 14 then
                G.GAME.current_round.bof_wooden_destroyed = G.GAME.current_round.bof_wooden_destroyed + 1
            end
            -- soapy deck
            if next(SMODS.get_enhancements(v)) ~= nil and v.edition ~= nil and v.seal ~= nil then
                check_for_unlock({ b_bof_soapy = true })
            end
        end
        -- wooden deck 2: electric boogaloo
        if G.GAME.current_round.bof_wooden_destroyed >= 4 then
            check_for_unlock({ b_bof_wooden = true })
        end
    end
end

SMODS.current_mod.optional_features = {
	retrigger_joker = true
}