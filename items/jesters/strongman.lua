BundlesOfFun.Joker {
    key = "strongman",
    name = "Strongman",
    bundle = "jesters",
    config = { extra = { mult = 1 } },
    pos = { x = 6, y = 4 },
    attributes = { "mult", "modify_card" },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.change_rank then
            local buffed_cards = {}
            for i, v in ipairs(G.playing_cards) do
                if v.base.id == context.new_rank then
                    v.ability.perma_mult = (v.ability.perma_mult or 0) + card.ability.extra.mult
                    table.insert(buffed_cards, v)
                end
            end
            context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.mult
            table.insert(buffed_cards, context.other_card)
            if #buffed_cards > 0 then
                card:juice_up()
                for _, v in ipairs(buffed_cards) do
                    if v.area ~= G.deck then
                        v:juice_up()
                    end
                end
            end
        end
    end,
    joker_display_def = function()
    end
}