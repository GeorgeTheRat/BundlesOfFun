-- im sorry for how i implemented this cause i literally had no idea on how to do it better :<

local function bof_has_sticker(card)
	for k, v in pairs(SMODS.Stickers) do
		if card.ability[k] then
			return true
		end
	end
	return false
end

local function remove_two_stickers(card)
    local yes = 0
     for i = 1, 2 do 
         local jokers = {}
        for k, v in pairs(G.jokers.cards) do
            if v ~= card and bof_has_sticker(v) then
                jokers[#jokers+1] = v
            end
        end
        if #jokers > 0 then
            local to_remove = pseudorandom_element(jokers, pseudoseed("RAAA"))
            local stickers_on_card = {}
            for k, v in pairs(SMODS.Stickers) do
                if to_remove.ability[k] then
                    stickers_on_card[#stickers_on_card+1] = k
                end
            end
            local sticker_to_remove = pseudorandom_element(stickers_on_card, pseudoseed("RAAA"))
            to_remove:remove_sticker(sticker_to_remove, true)
            if sticker_to_remove and to_remove then
             to_remove:juice_up()
             play_sound("tarot2")
             yes = yes + 1
            end
        end
    end
    if yes >= 2 then
        return true
    end
    return false
end

local function add_random_sticker(card)
    local sticker = pseudorandom_element(SMODS.Stickers, pseudoseed("RAAA")).key
    local jokers = {}
    for k, v in pairs(G.jokers.cards) do
        if v ~= card then
            jokers[#jokers+1] = v
        end
    end
    local to_add = pseudorandom_element(jokers, pseudoseed("RAAA"))
    if to_add and sticker then
        to_add:add_sticker(sticker, true)
        to_add:juice_up()
        play_sound("tarot1")
    end
end

SMODS.Joker {
    key = "n_notebook",
    name = "Notebook",
    blueprint_compat = false,
    config = { extra = { 
        dollars = 25,
        yes = false
    } },
    pos = { x = 5, y = 3 },
    cost = 5,
    rarity = 2,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            add_random_sticker(card)
        end
        if context.end_of_round and context.beat_boss and context.main_eval then
            card.ability.extra.yes = remove_two_stickers(card)
        end
    end,
    calc_dollar_bonus = function(self,card)
        if card.ability.extra.yes then
            card.ability.extra.yes = false
            return card.ability.extra.dollars
        end
    end
}