return {
    descriptions = {
        Joker = {
            j_bof_a_apple = {
                name = "Apple",
                text = {
                    "Each scored card",
                    "gains {C:mult}+#1#{} permanent Mult",
                    "Decreases by {C:attention}#2#{} at",
                    "end of round"
                }
            },
            j_bof_a_blueberry = {
                name = "Blueberry",
                text = {
                    "Each {C:attention}card{} held in hand",
                    "permanently gains {C:chips}+#1#{} Chip#<s>1#",
                    "Decreases by {C:chips}-#2#{} Chip#<s>2#",
                    "at end of round"
                }
            },
            j_bof_a_grapes = {
                name = "Grapes",
                text = {
                    "{C:chips}+#1#{} Chip#<s>1#, {C:mult}+#2#{} Mult, {C:white,X:mult}X#3#{} Mult",
                    "Destroyed when {C:attention}Boss Blind{} defeated"
                }
            },
            j_bof_a_durian = {
                name = "Durian",
                text = {
                    "Sell this Joker",
                    "card to fill {C:attention}consumable",
                    "slots with {C:tarot}The Fool"
                }
            },
            j_bof_a_apple_core = {
                name = "Apple Core",
                text = {
                    "The next {C:attention}#1#{}",
                    "cards grant {C:mult}+#2#{}",
                    "Mult instead of scoring"
                }
            },
            j_bof_a_dragonfruit = {
                name = "Dragonfruit",
                text = {
                    "{C:attention}Copy{} all cards in",
                    "next {C:blue}played{} hand,",
                    "or {C:attention}destroy{} all cards",
                    "in next {C:red}discarded{} hand"
                }
            },
            j_bof_a_jelly_beans = {
                name = "Jelly Beans",
                text = {
                    ""
                }
            },
            j_bof_a_shrimp = {
                name = "Shrimp",
                text = {
                    "{C:mult}Prevents Death{}",
                    "if chips scored are at",
                    "least {C:attention}#1#%{} of requirement",
                    "{C:inactive}({C:attention}#2#%{C:inactive} less each round)",
                    "{C:mult}Self-destructs"
                }
            },
            j_bof_a_tomato = {
                name = "Tomato",
                text = {
                    ""
                }
            },
            j_bof_a_wondrous_bread = {
                name = "Wondrous Bread",
                text = {
                    "Balance {C:white,B:1}#1#%{} of {C:chips}Chips{} and {C:mult}Mult",
                    "Decreases by {C:white,B:1}-#2#%{} at end of round"
                }
            }
        }
    },
    misc = {
        dictionary = {
            k_bof_savedbyshrimp = "Saved by delicious shrimp",
            k_bof_nom = "Nom!"
        }
    }
}