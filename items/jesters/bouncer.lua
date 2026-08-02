BundlesOfFun.Joker {
    key = "bouncer",
    name = "Bouncer",
    bundle = "jesters",
    config = {
        extra = {
            mult = 45,
            amount = 21
        }
    },
    pos = { x = 1, y = 5 },
    attributes = { "mult", "suit", "full_deck" },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.amount
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local suits = {}
            for _, key in ipairs(SMODS.Suit.obj_buffer) do
                local s = SMODS.Suits[key]
                suits[s.card_key] = 0
            end
            for _, playing_card in pairs(G.playing_cards) do
                if playing_card.base and playing_card.base.suit then
                    local suit_obj = SMODS.Suits[playing_card.base.suit]
                    if suit_obj then
                        local suit_card_key = suit_obj.card_key
                        if suits[suit_card_key] ~= nil then
                            suits[suit_card_key] = suits[suit_card_key] + 1
                        end
                    end
                end
            end
            for _, count in pairs(suits) do
                if count >= card.ability.extra.amount then
                    return {
                        mult = card.ability.extra.mult
                    }
                end
            end
        end
    end
}