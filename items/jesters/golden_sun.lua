BundlesOfFun.Joker {
    key = "golden_sun",
    name = "Mr. Golden Sun",
    bundle = "jesters",
    pos = { x = 3, y = 1 },
    attributes = { "mult", "chips", "destroy_card" },
    cost = 8,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.modify_hand then
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up(0.3, 0.5)
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.06*G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound("tarot2", 0.76, 0.4)
                            return true
                        end 
                    }))
                    play_sound("tarot2", 1, 0.4)
                    return true
                end 
            }))
            mult = mod_mult(math.max(math.floor(mult * 0.5 + 0.5), 1))
            hand_chips = mod_chips(math.max(math.floor(hand_chips * 0.5 + 0.5), 0))
            update_hand_text({}, { chips = hand_chips, mult = mult })
        end
        if context.discard and G.GAME.current_round.discards_left <= 1 and not context.blueprint then
            return {
                remove = true
            }
        end
    end
}