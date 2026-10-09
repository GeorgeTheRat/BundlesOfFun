BundlesOfFun.Blind {
    key = "aether",
    name = "Empyrean Aether",
    bundle = "finishers",
    pos = { y = 29 },
    attributes = {  },
    atlas = "blind",
    boss = { showdown = true },
    boss_colour = HEX("f38ca7"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.final_scoring_step then
            return {
                bof_unbalance_percent = 50,
                bof_plasma_animation = true,
                bof_fixed_sound_pitch = true
            }
        end
    end
}