-- bundle information: names and colors
-- i'm smart i know that word
-- pneumonoultramicroscopicsilicovolcanoconiosis
local BUNDLES = {
    appetizers = { name = "Appetizers", color = G.C.bof_appetizers },
    jesters = { name = "Jesters", color = G.C.bof_jesters },
    normalities = { name = "Normalities", color = G.C.bof_normalities },
    fables = { name = "Fables", color = G.C.bof_fables },
    flats = { name = "Flats", color = G.C.bof_flats },
    minnows = { name = "Minnows", color = G.C.bof_minnows },
    coupons = { name = "Coupons", color = G.C.bof_coupons },
    enemies = { name = "Enemies", color = G.C.bof_enemies }
}

-- hook into config changes to refresh badges
local original_SMODS_save_mod_config = SMODS.save_mod_config
function SMODS.save_mod_config(mod)
    original_SMODS_save_mod_config(mod)
    if mod.id == "BundlesOfFun" then
        BundlesOfFun.config = SMODS.current_mod.config or {}
        BundlesOfFun.config.bundles = BundlesOfFun.config.bundles or {}
        -- force refresh of all card badges by clearing badge cache and triggering UI recalculation
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.1,
            func = function()
                if G.jokers and G.jokers.cards then
                    for _, card in ipairs(G.jokers.cards) do
                        card.badges = nil
                        card:recalculate()
                    end
                end
                if G.consumeables and G.consumeables.cards then
                    for _, card in ipairs(G.consumeables.cards) do
                        card.badges = nil
                        card:recalculate()
                    end
                end
                if G.deck and G.deck.cards then
                    for _, card in ipairs(G.deck.cards) do
                        card.badges = nil
                        card:recalculate()
                    end
                end
                return true
            end
        }))
    end
end

local original_create_mod_badges = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
    if SMODS.config.no_mod_badges then
        return
    end

    if obj and obj.set == "Back" and obj.unlocked == false then
        return
    end

    -- calculate scale factor for text to fit badge
    local function calculate_scale_fac(text)
        local base_scale = 0.33 * 0.9
        local size = 0.8
        local font = G.LANG.font
        local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
        local calced_text_width = 0
        for _, c in utf8.chars(text) do
            calced_text_width = calced_text_width + (font.FONT:getWidth(c) * base_scale * G.TILESCALE * font.FONTSCALE + 2.7 * 1 * G.TILESCALE * font.FONTSCALE) / (G.TILESIZE * G.TILESCALE)
        end
        return calced_text_width > max_text_width and max_text_width / calced_text_width or 1
    end

    -- create single badge with cycling text
    local function create_bundle_badge(category_key)
        local category = BUNDLES[category_key]
        if not category then return nil end
        
        local strings = { localize("bof_" .. category_key), localize("bof_bof") }
        local scale_fac = {}
        local min_scale_fac = 1
        
        for i = 1, #strings do
            scale_fac[i] = calculate_scale_fac(strings[i])
            min_scale_fac = math.min(min_scale_fac, scale_fac[i])
        end
        
        local ct = {}
        for i = 1, #strings do
            ct[i] = {
                string = strings[i],
            }
        end
        
        return {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = {
                {
                    n = G.UIT.R,
                    config = {
                        align = "cm",
                        colour = category.color,
                        r = 0.1,
                        minw = 2,
                        minh = 0.32,
                        emboss = 0.05,
                        padding = 0.03 * 0.9,
                    },
                    nodes = {
                        { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                        {
                            n = G.UIT.O,
                            config = {
                                object = DynaText({
                                    string = ct,
                                    colours = { G.C.WHITE },
                                    silent = true,
                                    float = true,
                                    shadow = true,
                                    offset_y = -0.03,
                                    spacing = 1,
                                    scale = 0.36 * 0.8 * min_scale_fac
                                }),
                            },
                        },
                        { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                    },
                },
            },
        }
    end

    if obj and (obj.bundle or obj.key == "m_bof_wooden") then
        local category_name
        if type(obj.bundle) == "string" then
            category_name = obj.bundle
        elseif type(obj.bundle) == "table" then
            category_name = obj.bundle[1]
        end
        
        local badge = create_bundle_badge(category_name)
        if badge then
            badges[#badges + 1] = badge
        end
    else
        original_create_mod_badges(obj, badges)
    end
end

local original_HUD_blind_badge = G.FUNCS.HUD_blind_badge
G.FUNCS.HUD_blind_badge = function(e)
    if G.GAME.blind.in_blind and G.GAME.blind.config.blind and G.GAME.blind.config.blind.bundle then
        if not e.bof_badges_created then
            local blind = G.GAME.blind.config.blind
            local badges = {}
            SMODS.create_mod_badges(blind, badges)
            if #badges > 0 then
                local unwrapped_badges = {}
                for i = 1, #badges do
                    local badge = badges[i]
                    if badge.config then
                        badge.config.minw = 5
                        badge.config.maxw = 5
                    end
                    if badge.nodes and #badge.nodes > 0 then
                        for j = 1, #badge.nodes do
                            if badge.nodes[j].config then
                                badge.nodes[j].config.minw = 5
                                badge.nodes[j].config.maxw = 5
                            end
                        end
                    end
                    table.insert(unwrapped_badges, badge)
                end
                e.config.colour = G.C.TRANSPARENT
                e.config.emboss = 0
                for i = 1, #unwrapped_badges do
                    e.UIBox:add_child(unwrapped_badges[i], e)
                end
                e.bof_badges_created = true
            end
        end
        return
    end
    original_HUD_blind_badge(e)
end