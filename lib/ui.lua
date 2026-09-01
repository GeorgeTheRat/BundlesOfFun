-- credit tags
SMODS.Tag {
    key = "credit_george",
    pos = { x = 0, y = 0 },
    atlas = "credit",
    no_collection = true,
    no_mod_badges = true,
    in_pool = function()
        return false
    end
}
SMODS.Tag {
    key = "credit_glitch",
    pos = { x = 1, y = 0 },
    atlas = "credit",
    no_collection = true,
    no_mod_badges = true,
    in_pool = function()
        return false
    end
}
SMODS.Tag {
    key = "credit_amo",
    pos = { x = 3, y = 1 },
    atlas = "credit",
    no_collection = true,
    no_mod_badges = true,
    in_pool = function()
        return false
    end
}
SMODS.Tag {
    key = "credit_marffe",
    pos = { x = 2, y = 0 },
    atlas = "credit",
    no_collection = true,
    no_mod_badges = true,
    in_pool = function()
        return false
    end
}
SMODS.Tag {
    key = "credit_revo",
    pos = { x = 2, y = 1 },
    atlas = "credit",
    no_collection = true,
    no_mod_badges = true,
    in_pool = function()
        return false
    end
}
SMODS.Tag {
    key = "credit_arc",
    pos = { x = 1, y = 1 },
    atlas = "credit",
    no_collection = true,
    no_mod_badges = true,
    in_pool = function()
        return false
    end
}
SMODS.Tag {
    key = "credit_sophe",
    pos = { x = 4, y = 0 },
    atlas = "credit",
    no_collection = true,
    no_mod_badges = true,
    in_pool = function()
        return false
    end
}
SMODS.Tag {
    key = "credit_lapsem",
    pos = { x = 0, y = 1 },
    atlas = "credit",
    no_collection = true,
    no_mod_badges = true,
    in_pool = function()
        return false
    end
}
SMODS.Tag {
    key = "credit_minty",
    pos = { x = 3, y = 0 },
    atlas = "credit",
    no_collection = true,
    no_mod_badges = true,
    in_pool = function()
        return false
    end
}
SMODS.Tag {
    key = "credit_drunk",
    pos = { x = 4, y = 1 },
    atlas = "credit",
    no_collection = true,
    no_mod_badges = true,
    in_pool = function()
        return false
    end
}

-- create toggle ui element for bundle
local function bundle_toggle(item, colour)
    return { n = G.UIT.R, config = { align = "cm" }, nodes = {
        create_toggle{
            label = localize("bof_" .. item),
            active_colour = colour,
            col = true,
            label_scale = 0.4,
            ref_table = BundlesOfFun.config.bundles,
            ref_value = item,
            align = "cm"
        }
    }}
end

-- basically just copying the function in engine/ui.lua to generate tags in the collection
-- works well though
local function credit_tag_sprite(tag_key, tag_pos)
    local full_key = nil
    for k, _ in pairs(G.P_TAGS) do
        if k:sub(-#tag_key) == tag_key then
            full_key = k
            break
        end
    end
    local tag_def = G.P_TAGS[full_key]
    local tag_sprite = SMODS.create_sprite(
        0, 0,
        1.5, 1.5,
        SMODS.get_atlas(tag_def.atlas),
        tag_pos
    )
    tag_sprite.T.scale = 1
    tag_sprite:define_draw_steps({
        { shader = "dissolve", shadow_height = 0.05 },
        { shader = "dissolve" },
    })
    tag_sprite.float = true
    tag_sprite.states.hover.can = true
    tag_sprite.states.drag.can = false
    tag_sprite.states.collide.can = true
    tag_sprite.config = {
        tag = tag_def,
        force_focus = true
    }
    tag_sprite.hover = function(self)
        if not G.CONTROLLER.dragging.target
        and not G.CONTROLLER.using_touch
        and not self.hovering
        and self.states.visible then
            self.hovering = true
            self.hover_tilt = 3
            self:juice_up(0.05, 0.02)
            play_sound("paper1", math.random() * 0.1 + 0.55, 0.42)
            play_sound("tarot2", math.random() * 0.1 + 0.55, 0.09)
            self.ability_UIBox_table = generate_card_ui(
                tag_def,
                nil,
                {},
                'Tag',
                nil,
                false,
                nil,
                nil,
                tag_def
            )
            self.config.h_popup = G.UIDEF.card_h_popup(self)
            self.config.h_popup_config =
                (self.T.x > G.ROOM.T.w * 0.4)
                and {
                    align = 'cl',
                    offset = { x = -0.1, y = 0 },
                    parent = self
                }
                or {
                    align = 'cr',
                    offset = { x = 0.1, y = 0 },
                    parent = self
                }
            Node.hover(self)
        end
    end
    tag_sprite.stop_hover = function(self)
        self.hovering = false
        Node.stop_hover(self)
        self.hover_tilt = 0
    end
    tag_sprite:juice_up(0.1, 0.3)
    return {
        n = G.UIT.C,
        config = {
            align = "cm",
            padding = 0.1
        },
        nodes = {
            {
                n = G.UIT.O,
                config = {
                    object = tag_sprite,
                    focus_with_object = true,
                    w = 1.5,
                    h = 1.5
                }
            }
        }
    }
end

-- store reference to tab content
G.FUNCS.bof_store_tab_ref = function(e)
    local p = e.parent
    while p do
        if p.config and p.config.object and p.config.object.UIRoot then
            BundlesOfFun.tab_content_box = p
            break
        end
        p = p.parent
    end
    e.config.func = nil
end

-- config tab with... well what do you expect
SMODS.current_mod.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = {
            emboss = 0.05,
            minh = 6,
            r = 0.1,
            minw = 10,
            align = "cm",
            padding = 0.3,
            colour = G.C.BLACK,
        },
        nodes = {
            { n = G.UIT.R, config = { align = "cm", padding = 0.4 }, nodes = {
                create_toggle {
                    label = "Custom Sounds",
                    ref_table = BundlesOfFun.config,
                    ref_value = "custom_sounds",
                },
                create_toggle {
                    label = "evil dih (joke setting)",
                    ref_table = BundlesOfFun.config,
                    ref_value = "evil_dih",
                }
            }}
        }
    }
end

-- define the tabs for bundles and credits
SMODS.current_mod.extra_tabs = function()
    return {
        {
            label = "Bundles",
            tab_definition_function = function()
                return {
                    n = G.UIT.ROOT,
                    config = {
                        emboss = 0.05,
                        minh = 6,
                        r = 0.1,
                        minw = 10,
                        align = "cm",
                        padding = 0.3,
                        colour = G.C.BLACK,
                    },
                    nodes = {
                        { n = G.UIT.R, config = { align = "cm", padding = 0.2 }, nodes = {
                            { n = G.UIT.C, config = { align = "cm", minw = 5 }, nodes = {
                                bundle_toggle("appetizers", G.C.bof_appetizers),
                                bundle_toggle("jesters", G.C.bof_jesters),
                                bundle_toggle("normalities", G.C.bof_normalities),
                                bundle_toggle("fables", G.C.bof_fables),
                            }},
                            { n = G.UIT.C, config = { align = "cm", minw = 5 }, nodes = {
                                bundle_toggle("flats", G.C.bof_flats),
                                bundle_toggle("minnows", G.C.bof_minnows),
                                bundle_toggle("coupons", G.C.bof_coupons),
                                bundle_toggle("enemies", G.C.bof_enemies),
                            }}
                        }},
                        { n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
                            { n = G.UIT.O, config = {
                                object = DynaText({
                                    string = { "Some items only appear if multiple sets are enabled" },
                                    colours = { G.C.WHITE },
                                    scale = 0.4,
                                    shadow = true,
                                    bump = true
                                })
                            } }
                        }},
                        { n = G.UIT.R, config = { func = "bof_store_tab_ref" } },
                    }
                }
            end
        },
        {
            label = "Credits",
            tab_definition_function = function()
                return {
                    n = G.UIT.ROOT,
                    config = {
                        emboss = 0.05,
                        minh = 6,
                        r = 0.1,
                        minw = 10,
                        align = "cm",
                        padding = 0.3,
                        colour = G.C.BLACK,
                    },
                    nodes = {
                        -- The outer container is a Column (C) to stack the two rows vertically
                        { n = G.UIT.C, config = { align = "cm", padding = 0.2 }, nodes = {
                            -- Top Row
                            { n = G.UIT.R, config = { align = "cm", minw = 5 }, nodes = {
                                credit_tag_sprite("credit_george", { x = 0, y = 0 }),
                                credit_tag_sprite("credit_glitch", { x = 1, y = 0 }),
                                credit_tag_sprite("credit_amo", { x = 2, y = 0 }),
                                credit_tag_sprite("credit_marffe", { x = 3, y = 0 }),
                                credit_tag_sprite("credit_revo", { x = 4, y = 0 }),
                            }},
                            -- Bottom Row
                            { n = G.UIT.R, config = { align = "cm", minw = 5 }, nodes = {
                                credit_tag_sprite("credit_arc", { x = 0, y = 1 }),
                                credit_tag_sprite("credit_sophe", { x = 1, y = 1 }),
                                credit_tag_sprite("credit_lapsem", { x = 2, y = 1 }),
                                credit_tag_sprite("credit_minty", { x = 3, y = 1 }),
                                credit_tag_sprite("credit_drunk", { x = 4, y = 1 }),
                            }}
                        }}
                    }
                }
            end
        }
    }
end


