-- increase blind size by 5% (0.05) per card discarded, not 10% (0.1)
-- this is due too the blind already being 2x base (as boss blinds are)
-- which would make 10% (0.1) act like scaling 20% (0.2) base blind size
BundlesOfFun.Blind {
    key = "angle",
    name = "The Angle",
    bundle = "enemies",
    pos = { y = 7 },
    atlas = "blind",
    boss = { min = 3 },
    boss_colour = HEX("7888a8"),
    calculate = function(self, blind, context)
        if context.setting_blind then
            G.GAME.bof_angle_base_chips = G.GAME.blind.chips
            G.GAME.bof_angle_discarded_cards = {}
            G.GAME.current_round.discards_left = math.max(0, G.GAME.current_round.discards_left - 1)
        end

        if blind.disabled then return end

        -- dedup by sort_id so a card only counts once
        if context.discard and context.other_card and context.other_card.sort_id then
            G.GAME.bof_angle_discarded_cards = G.GAME.bof_angle_discarded_cards or {}
            local id = context.other_card.sort_id
            if not G.GAME.bof_angle_discarded_cards[id] then
                G.GAME.bof_angle_discarded_cards[id] = true
                local base = G.GAME.bof_angle_base_chips or G.GAME.blind.chips
                G.GAME.blind.chips = math.floor(G.GAME.blind.chips + base * 0.05)
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                blind:wiggle()
            end
        end
    end
}