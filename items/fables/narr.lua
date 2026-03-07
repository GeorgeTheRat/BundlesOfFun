local function suit()
    return (G.GAME.bof_narr_card or {}).suit or "Spades"
end

local function suit_count()
    local count = 0
    if G.playing_cards then
        for _, v in pairs(G.playing_cards) do
            if v:is_suit(suit()) then count = count + 1 end
        end
    end
    return count
end

SMODS.Joker {
    key = "f_narr",
    name = "Narr",
    config = {
        extra = { 
            xmult_mod = 0.01,
            xmult = 1
        } 
    },
    pos = { x = 0, y = 4 },
    soul_pos = { x = 0, y = 5 },
    cost = 20,
    rarity = 4,
    unlocked = false,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { 
            vars = {
                card.ability.extra.xmult_mod,
                localize(suit(), "suits_singular"),
                card.ability.extra.xmult,
                colours = { G.C.SUITS[suit()] }
            }
        }
    end,
    calculate = function(self, card, context)
        if suit_count() ~= 0 and context.end_of_round and context.main_eval and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmult_mod",
                message_colour = G.C.MULT,
                operation = function(ref_table, ref_value, initial, change)
                    ref_table[ref_value] = ref_table[ref_value] + suit_count() * change
                end
            })
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

-- initialize suit at start of run
local last_start_run = Game.start_run
function Game:start_run(args)
    local r = last_start_run(self, args)
    G.E_MANAGER:add_event(Event({
        func = function()
            G.GAME.bof_narr_card = G.GAME.bof_narr_card or {}
            G.GAME.bof_narr_card.suit = pseudorandom_element({ "Spades", "Hearts", "Clubs", "Diamonds" }, "j_bof_f_narr")
            G.GAME.bof_bundles = copy_table(BundlesOfFun.config.bundles)
            return true
        end,
        blocking = false
    }))
    return r
end
