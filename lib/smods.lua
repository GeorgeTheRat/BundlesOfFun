SMODS.Atlas({
    key = "joker", 
    path = "joker.png", 
    px = 71,
    py = 95, 
})

SMODS.Atlas({
    key = "placeholder", 
    path = "placeholder.png", 
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
	key = "alarm_wind",
	path = "alarm_wind.ogg",
	loop = false
})

SMODS.DynaTextEffect {
    key = "alarm",
    func = function(dynatext, index, letter)
        letter.offset.x = math.sin((G.TIMERS.REAL + index)*(40 + index*5)) * 3
        letter.offset.y = math.cos((G.TIMERS.REAL + index)*(45 + index*5)) * 3
        letter.r = math.sin((G.TIMERS.REAL + index)*(25 + index*3)) * 0.1
    end
}

SMODS.ConsumableType({
    key = "Fish",
    primary_colour = { 1.0, 0.6, 0.7, 1 },
    secondary_colour = { 0.85, 0.45, 0.55, 1 },
    collection_rows = { 2, 2 },
    shop_rate = 0,
    select_card = "consumeables",
    default = "c_bof_i_bass_s"
})

SMODS.ObjectType({
    key = "fish_s",
    select_card = "consumeables",
    default = "c_bof_i_bass_s",
})

SMODS.ObjectType({
    key = "fish_b",
    select_card = "consumeables",
    default = "c_bof_i_bass_b"
})

SMODS.ObjectType({
    key = "fish_l",
    select_card = "consumeables",
    default = "c_bof_i_bass_l"
})

SMODS.UndiscoveredSprite({
    key = "Fish",
    atlas = "fish_blank",
    pos = { x = 0, y = 0 }
})

SMODS.current_mod.calculate = function(self, context)
    if context.end_of_round and context.main_eval then
        G.GAME.current_round.bof_wooden_destroyed = 0
    end
    if context.remove_playing_cards then
        G.GAME.current_round.bof_wooden_destroyed = G.GAME.current_round.bof_wooden_destroyed or 0
        for k, v in pairs(context.removed or {}) do
            if v:get_id() == 14 then
                G.GAME.current_round.bof_wooden_destroyed = G.GAME.current_round.bof_wooden_destroyed + 1
            end
            if next(SMODS.get_enhancements(v)) ~= nil and v.edition ~= nil and v.seal ~= nil then
                check_for_unlock({ b_bof_l_soapy = true })
            end
        end
        if G.GAME.current_round.bof_wooden_destroyed >= 4 then
            check_for_unlock({ b_bof_l_wooden = true })
        end
    end
end

SMODS.current_mod.optional_features = {
	retrigger_joker = true
}