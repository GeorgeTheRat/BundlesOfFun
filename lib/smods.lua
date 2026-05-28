SMODS.Atlas({
    key = "modicon", 
    path = "icon.png", 
    px = 34,
    py = 34,
})

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

-- SMODS.DynaTextEffect {
--     key = "alarm",
--     func = function(dynatext, index, letter)
--         letter.offset.x = math.sin((G.TIMERS.REAL + index)*(40 + index*5)) * 3
--         letter.offset.y = math.cos((G.TIMERS.REAL + index)*(45 + index*5)) * 3
--         letter.r = math.sin((G.TIMERS.REAL + index)*(25 + index*3)) * 0.1
--     end
-- }

SMODS.current_mod.optional_features = {
	retrigger_joker = true
}