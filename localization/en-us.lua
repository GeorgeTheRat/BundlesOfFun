return {
    descriptions = {
        Joker = {
            j_bof_a_dragonfruit = {
                name = "Dragonfruit",
                text = {
                    "Create a permanent copy of",
                    "all {C:attention}played{} cards next hand to deck",
                    "or destroy all cards in",
                    "next {C:attention}discarded{} poker hand"
                }
            },
            j_bof_a_blueberry = {
                name = "Blueberry",
                text = {
                    "Each {C:attention}card{} held in hand",
                    "permanently gains {C:chips}+#1#{} Chip#<s>1#,",
                    "decreases by {C:chips}-#2#{} Chip#<s>2#",
                    "at end of round"
                }
            },
            j_bof_a_grapes = {
                name = "Grapes",
                text = {
                    "{C:chips}+#1#{} Chip#<s>1#, {C:mult}+#2#{} Mult, {C:white,X:mult}X#3#{} Mult",
                    "Destroyed when {C:attention}Boss Blind{} is defeated"
                }
            },
            j_bof_a_leek = {
                name = "Leek",
                text = {
                    "Increase all {C:attention}listed",
                    "{C:green,E:1}probabilities{} by {C:green}+#1#,",
                    "decreases by {C:red}-#2#{} when",
                    "a {C:green}probability{} succeeds",
                }
            },
            j_bof_a_durian = {
                name = "Durian",
                text = {
                    "Sell this Joker to",
                    "fill {C:attention}consumable slots",
                    "with {C:tarot}The Fool"
                }
            },
            j_bof_a_wonderous_bread = {
                name = "Wonderous Bread",
                text = {
                    "Balance {C:white,X:plasma}#1#%{} of {C:chips}Chips{} and {C:mult}Mult,",
                    "decreases by {C:white,X:plasma}-#2#%{} at end of round"
                }
            },
            j_bof_a_jelly_beans = {
                name = "Jelly Beans",
                text = {
                    "The next {C:attention}#1# Blind#<s>1#{} skipped,",
                    "create a {C:attention}Juggle Tag"
                }
            },
            j_bof_a_apple = {
                name = "Apple",
                text = {
                    "Each scored card",
                    "permanently gains {C:mult}+#1#{} Mult,",
                    "decreases by {C:mult}-#2#{} Mult",
                    "at end of round"
                }
            },
            j_bof_a_apple_core = {
                name = "Apple Core",
                text = {
                    "The next {C:attention}#1#",
                    "cards give {C:mult}+#2#{} Mult",
                    "instead of scoring"
                }
            },
            j_bof_a_tomato = {
                name = "Tomato",
                text = {
                    "The next {C:attention}#1#{} cards",
                    "held in hand have a",
                    "{C:green}#2# in #3#{} chance of becoming",
                    "{C:attention}Mult Cards{} or {C:attention}Lucky Cards"
                }
            },
            j_bof_j_hal = {
                name = "Hatty Hal",
                text = {
                    "This Joker gains {C:chips}+#1#{} Chip#<s>1# and",
                    "increases its {C:attention}scaling{} by {C:chips}+#2#{} Chip#<s>2#",
                    "when a {C:attention}playing card",
                    "is added to your deck",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chip#<s>3#)"
                }
            },
            -- j_bof_j_henry = {
            --     name = "Handy Henry",
            --     text = {
            --         "{C:blue}+#1#{} hand per round",
            --         "and {C:attention}#2#{} hand size",
            --         "for every Joker",
            --         "to the {C:attention}left"
            --     }
            -- },
            j_bof_j_tom = {
                name = "Tumor Tom",
                text = {
                    "{C:dark_edition}+#1#{} Joker slots",
                    "{C:attention}Consumable slots{} are",
                    "set to {C:attention}0",
                }
            },
            j_bof_j_barber = {
                name = "Barber",
                text = {
                    "Earn {C:money}$#1#{} at end of round",
                    "{C:green}#2# in #3#{} chance to",
                    "increase {C:money}payout{} by {C:money}$#4#",
                    "when {C:attention}Blind{} is selected"
                }
            },
            j_bof_j_ballbo = {
                name = "Ballbo",
                text = {
                    "This Joker gains {C:mult}+#1#{} Mult and",
                    "increases its {C:attention}scaling{} by {C:mult}+#2#{} Mult",
                    "if played hand contains a {C:attention}Flush",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
                }
            },
            j_bof_j_rogue = {
                name = "Rogue",
                text = {
                    "Cards with {C:spades}Spade",
                    "or {C:clubs}Club{} suit give",
                    "{C:money}$#1#{} when held in hand",
                    "at end of round"
                }
            },
            j_bof_j_eddrick = {
                name = "Evil Eddrick",
                text = {
                    "{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
                    "on {C:attention}final hand{} of round"
                }
            },
            j_bof_j_super = {
                name = "Super Joker",
                text = {
                    "{C:blue}+#1#{} hands if {C:attention}Blind{} is",
                    "not won by final hand,",
                    "{s:0.8}may only trigger once per round"
                }
            },
            j_bof_j_eureka = {
                name = "Emmanuel E. \"Eureka\"",
                text = {
                    {
                        "{C:tarot}Arcana Packs{} may contain",
                        "{C:attention}consumables{} of all types"
                    },
                    {
                        "{C:spectral}Spectral Packs{} and {C:planet}Celestial Packs",
                        "may contain {C:tarot}Tarot{} cards"
                    }
                }
            },
            j_bof_j_timmy = {
                name = "Youngster Timmy",
                text={
                    "{C:blue}+#1#{} Chip#<s>1# for each",
                    "card above {C:attention}#2#",
                    "in your full deck",
                    "{C:inactive}(Currently {C:blue}+#3#{C:inactive} Chip#<s>3#)"
                },
            },
            j_bof_j_gary = {
                name = "Geezer Gary",
                text = {
                    "This Joker gains {C:chips}+#1#{} Chip#<s>1#",
                    "when a Joker is {C:attention}sold{},",
                    "increases by {C:chips}+#2#{} Chip#<s>2# when",
                    "{C:attention}Boss Blind{} is defeated",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chip#<s>3#)"
                }
            },
            j_bof_j_golden_sun = {
                name = "Mr. Golden Sun",
                text = {
                    "{C:white,X:mult}X#1#{} Mult",
                    "{C:red}Destroy{} all cards",
                    "in final {C:attention}discarded",
                    "{C:attention}poker hand{} each round"
                }
            },
            j_bof_j_jack_frost = {
                name = "Jack Frost",
                text = {
                    "{C:mult}+#1#{} Mult if played",
                    "{C:attention}poker hand{} has",
                    "not already been ",
                    "played this round"
                }
            },
            j_bof_j_jim = {
                name = "Slim Jim",
                text = {
                    "{C:blue}+#1#{} hand per round",
                    "{C:red}+#2#{} discard each round",
                    "{C:attention}#3#{} hand size"
                }
            },
            j_bof_j_gumphrey = {
                name = "Gumphrey",
                text = {
                    "{C:mult}+#1#{} Mult for every",
                    "{C:attention}Enhanced{} card in",
                    "your {C:attention}full deck",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                }
            },
            j_bof_j_soothsayer = {
                name = "Soothsayer",
                text = {
                {
                    "Creates a {C:tarot}Tarot{} card if a",
                    "card with a {C:tarot}Purple Seal{} is",
                    "held in hand at end of round",
                },
                {
                    "Upgrade level of discarded",
                    "{C:attention}poker hand{} if discarded hand",
                    "contains a card with a {C:blue}Blue Seal",
                },
                },
            },
            j_bof_j_polymath = {
                name = "Polymath",
                text = {
                    "Each card scored and held in hand",
                    "has a {C:green}#1# in #2#{} chance to give",
                    "{C:mult}+#3#{} Mult, {C:chips}+#4#{} Chip#<s>4#, {C:white,X:mult}X#5#{} Mult, and {C:money}$#6#"
                }
            },
            j_bof_j_luminary = {
                name = "Luminary",
                text = {
                    "Earn {C:money}$#1#{} at end of round",
                    "Increase payout by {C:money}$#2#{} for each",
                    "played hand that contains a",
                    "{C:attention}played{} and {C:attention}unscoring{} card with",
                    "{C:hearts}Heart{} or {C:diamonds}Diamond{} suit this round"
                }
            },
            j_bof_j_furious = {
                name = "Furious Joker",
                text = {
                    "Earn {C:money}$#1#{} at end",
                    "of round",
                    "Earn no {C:attention}interest"
                }
            },
            j_bof_j_larry = {
                name = "Laggard Larry",
                text = {
                    "Earn {C:money}$#1#{} when",
                    "{C:attention}first{} or {C:attention}last hand",
                    "of round is played"
                }
            },
            j_bof_j_phony = {
                name = "Phony",
                text = {
                    "{C:mult}+#1#{} Mult",
                    "{C:chips}-#2#{} Chips"
                }
            },
            j_bof_j_frank = {
                name = "Frank Fop",
                text = {
                    "Create either a {C:attention}Handy Tag{} or",
                    "{C:attention}Garbage Tag{} at random when",
                    "{C:blue}Small Blind{} is selected",
                }
            },
            j_bof_j_crafted = {
                name = "Crafted Joker",
                text = {
                    "Earn money equal to",
                    "the current number of",
                    "{C:attention}rounds{} completed when any",
                    "{C:attention}Booster Pack{} is skipped",
                    "{C:red,E:2}self destructs"
                }
            },
            j_bof_j_schlitzohr = {
                name = "Schlitzohr",
                text = {
                    "Destroy a random {C:attention}card",
                    "in played hand",
                    "This Joker cannot destroy cards",
                    "played on {C:attention}final hand{} of round"
                }
            },
            j_bof_j_hotboxer = {
                name = "Hotboxer",
                text = {
                    "If {C:attention}final discard{} of",
                    "round has only {C:attention}#1#{} card,",
                    "either add a {C:attention}permanent",
                    "{C:attention}copy{} to deck or destroy it"
                }
            },
            j_bof_n_notebook = {
                name = "Notebook",
                text = {
                    {
                        "Apply a {C:dark_edition}sticker{} to",
                        "a random Joker",
                        "when {C:attention}Blind{} is selected"
                    },
                    {
                        "{C:red}Remove{} two {C:dark_edition}stickers{}",
                        "and earn {C:money}$#1#{}",
                        "when {C:attention}Boss Blind",
                        "is defeated"
                    }
                }
            },
            j_bof_n_eraser = {
                name = "Eraser",
                text = {
                    "All cards held in hand give",
                    "{C:mult}+#1#{} Mult but {C:red}lose{} any",
                    "{C:attention}modifications{} they have"
                }
            },
            j_bof_n_rummikub = {
                name = "Rummikub Tile",
                text = {
                    "This {C:attention}Joker{} gains {C:chips}+#1#{} Chip#<s>1#",
                    "if the {C:attention}total{} chip value of ",
                    "played cards is at least {C:attention}#2#",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chip#<s>3#)" 
                }
            },
            j_bof_n_alarm_clock = {
                name = "Alarm Clock",
                text = {
                    "{X:mult,C:white}X#1#{} Mult every",
                    "{C:attention}other{} hand",
                    "{C:inactive}#2#", -- see: loyalty card
                }
            },
            j_bof_n_passport = {
                name = "Passport",
                text = {
                    {
                        "This Joker gains {C:chips}+#1#{} Chips",
                        "for each {C:attention}unique Blind{} defeated",
                        "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
                    },
                    {
                        "{C:attention}Boss Blinds{} may appear",
                        "multiple times"
                    }
                }
            },
            j_bof_f_narr = {
                name = "Narr",
                text = {
                    "This Joker gains {C:white,X:mult}X#1#{} Mult",
                    "for every {C:attention}card{} with {V:1}#2#{} suit",
                    "in your deck at end of round",
                    "{C:inactive}(Currently {C:white,X:mult}X#3#{C:inactive} Mult)"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_f_manqian = {
                name = "Manqian",
                text = {
                    "{C:white,X:mult}Multiply{C:mult} Mult{} by",
                    "{C:attention}level{} of most played",
                    "{C:attention}poker hand{} before scoring",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive} at {V:1}lvl.#2#{C:inactive})"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_f_turold = {
                name = "Turold",
                text = {
                    "This Joker gains {C:white,X:mult}X#1#{} Mult",
                    "when hand is played,",
                    "{C:attention}resets{} at end of round",
                    "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult)"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_f_taillefer = {
                name = "Taillefer",
                text = {
                    "Fill {C:attention}consumable slots",
                    "with random {C:spectral}Spectral{} cards",
                    "when {C:attention}Blind{} is selected"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_f_dagonet = {
                name = "Dagonet",
                text = {
                    "Played {C:attention}Stone Cards{} give",
                    "{C:mult}+#1#{} Mult when scored,",
                    "increases by {C:mult}+#2#{} Mult when",
                    "a {C:attention}Stone Card{} is discarded"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            }
        },
        Back = {
            -- b_bof_l_embroidered = {
            --     name = "Embroidered Deck",
            --     text = {
            --         "Start with one random {C:attention}rank{} missing from deck",
            --         "When {C:attention}Boss Blind{} is defeated,",
            --         "add {C:attention}4{} cards to deck with each",
            --         "{C:attention}suit{} of one random {C:attention}rank",
            --         "{C:inactive,s:0.8}(ex: {C:attention,s:0.8}K of Hearts{C:inactive,s:0.8}, {C:attention,s:0.8}K of Spades{C:inactive,s:0.8}, {C:attention,s:0.8}K of Diamonds{C:inactive,s:0.8}, {C:attention,s:0.8}K of Clubs{C:inactive,s:0.8})"
            --     },
            --     unlock = {
            --         "Have {C:attention}80{} or more",
            --         "cards in your deck"
            --     }
            -- },
            b_bof_l_flannel = {
                name = "Flannel Deck",
                text = {
                    "{C:mult}+#1#{} Mult"
                },
                unlock = {
                    "Get the base {C:mult}Mult",
                    "of any {C:attention}poker hand",
                    "to at least {C:attention}75"
                }
            },
            b_bof_l_illusion = {
                name = "Illusion Deck",
                text = {
                    "When a {C:attention}Boss Blind",
                    "is defeated, increase",
                    "hands or discards by",
                    "{C:plasma}+#1#{} for the next {C:attention}Ante"
                },
                unlock = {
                    "Win a run with",
                    "{C:attention}#1#{} on {V:1}#2#",
                    "or {C:attention}#3#{} on {V:2}#4#"
                }
            },
            -- b_bof_l_fossilized = {
            --     name = "Fossilized Deck",
            --     text = {
            --         "Earn an additional {C:money}+$2{} at",
            --         "end of round for each {C:attention}consumable{} held",
            --         "{C:attention}Consumables{} in shop may rarely be {C:dark_edition}Negative"
            --     },
            --     unlock = {
            --         "Have one of each",
            --         "{C:attention}base consumable type{}",
            --         "in consumable slots"
            --     }
            -- },
            b_bof_l_wooden = {
                name = "Wooden Deck",
                text = {
                    "Start with no {C:attention}Aces{}",
                    "and an additional full",
                    "rank of {C:attention}2s{}, {C:attention}3s{},",
                    "{C:attention}4s{}, and {C:attention}5s"
                },
                unlock = {
                    "Destroy {C:attention}4 Aces",
                    "in one round"
                }
            },
            -- b_bof_l_backgammon = {
            --     name = "Backgammon Deck",
            --     text = {
            --         "Convert each scored card with",
            --         "{C:spades}Spade{} or {C:clubs}Club{} suit into {C:hearts}Heart{}",
            --         "or {C:diamonds}Diamond{} suit and vice versa",
            --         "No effect if Joker slots are full"
            --     },
            --     unlock = {
            --         "Have exactly {C:attention}10{} cards of",
            --         "each suit in your deck"
            --     }
            -- },
            -- b_bof_l_retro = {
            --     name = "Retro Deck",
            --     text = {
            --         "Increase the level of",
            --         "{C:attention}#1#{} random {C:attention}poker hands",
            --         "when {C:attention}Blind{} is skipped"
            --     },
            --     unlock = {
            --         "Play all {C:attention}poker hands",
            --         "at least once in one run"
            --     }
            -- },
            -- b_bof_l_display = {
            --     name = "Display Deck",
            --     text = {
            --         "Start with all {C:attention}ranks{} of one {C:attention}suit",
            --         "When {C:attention}Boss Blind{} defeated,",
            --         "add a copy of every {C:attention}rank",
            --         "of a random {C:attention}suit{} to deck"
            --     },
            --     unlock = {
            --         "Have only one",
            --         "{C:attention}rank{} in deck"
            --     }
            -- },
            b_bof_l_soapy = {
                name = "Soapy Deck",
                text = {
                    "{C:attention}Enhanced{} cards are",
                    "destroyed when {C:attention}discarded"
                },
                unlock = {
                    "Destroy a card with an",
                    "{C:enhanced}Enhancement{}, {C:dark_edition}Edition{},",
                    "and {C:attention}Seal{}"
                }
            },
            -- b_bof_l_lightning = {
            --     name = "Lightning Deck",
            --     text = {
            --         "{C:attention}Face cards{} start",
            --         "as {C:attention}Mult Cards",
            --         "Played cards do not give their",
            --         "{C:attention}base chips{} when scored"
            --     },
            --     unlock = {
            --         "Win a run",
            --         "without any {C:mult}Mult{},",
            --         "{C:white,s:0.8,X:mult}XMult{s:0.8} may still be used"
            --     }
            -- }
        },
        -- Voucher = {
        --     v_bof_dark_alley = {
        --         name = "Dark Alley",
        --         text = {
        --             "{C:inactive}It's dark in here..."
        --         }
        --     },
        --     v_bof_illegal_wares = {
        --         name = "Illegal Wares",
        --         text = {
        --             "{C:spectral}Spectral cards may appear in shop",
        --             "{C:attention}Consumables{} may rarely appear {C:dark_edition}Negative"
        --         },
        --         unlock = {
        --             "Have at least",
        --             "{C:attention,E:1}3 Spectral cards",
        --             "in your consumable slots"
        --         }
        --     },
        --     v_bof_unboxing = {
        --         name = "Unboxing",
        --         text = {
        --             "{C:attention}Regular Booster Packs{} may",
        --             "appear in shop slots"
        --         }
        --     },
        --     v_bof_scalping = {
        --         name = "Scalping",
        --         text = {
        --             "{C:attention}Jumbo{} and {C:attention}Mega Booster Packs",
        --             "may appear in shop slots"
        --         },
        --         unlock = {
        --             "Skip a total of {C:attention,E:1}30",
        --             "Jumbo or Mega Booster Packs"
        --         }
        --     },
        --     v_bof_dumpster_diving = {
        --         name = "Dumpster Diving",
        --         text = {
        --             "Create a random {C:attention}Tag{} when",
        --             "{C:attention}Boss Blind{} is selected"
        --         }
        --     },
        --     v_bof_raccoon_tactics = {
        --         name = "Raccoon Tactics",
        --         text = {
        --             "Create a random {C:attention}Tag{} when",
        --             "{C:attention}Blind{} is selected"
        --         },
        --         unlock = {
        --             "Have at least",
        --             "{C:attention,E:1}3{} Double Tags"
        --         }
        --     },
        --     v_bof_scratch_off = {
        --         name = "Scratch-Off",
        --         text = {
        --             "Redeem a random {C:attention}Voucher{} if both",
        --             "{C:small,E:1}Small Blind{} and {C:big,E:1}Big Blind",
        --             "are skipped in an {C:attention}Ante"
        --         }
        --     },
        --     v_bof_lottery_ticket = {
        --         name = "Lottery Ticket",
        --         text = {
        --             "{C:attention}Vouchers{} may rarely",
        --             "appear in shop slots"
        --         },
        --         unlock = {
        --             "Have at least",
        --             "{C:attention,E:1}8{} Vouchers"
        --         }
        --     },
        --     v_bof_phishing = {
        --         name = "Phishing",
        --         text = {
        --             "Jokers costing {C:money}$#1#{}",
        --             "or below are {C:attention}free"
        --         }
        --     },
        --     v_bof_social_engineering = {
        --         name = "Social Engineering",
        --         text = {
        --             "Jokers costing {C:money}$#1#{}",
        --             "or below are {C:attention}free"
        --         },
        --         unlock = {
        --             "Purchase a Joker costing",
        --             "{C:attention,E:1}$12{} or more"
        --         }
        --     }
    },
    misc = {
        dictionary = {
            k_bof_nom = "Nom!",
            bof_active = "Active!",
            bof_inactive = "Inactive...",
            bof_ready = "Ready!",
            k_bof_destroyed = "Destroyed!",
            k_bof_ring = "Ring Ring!",
            k_bof_alarm = "Alarm Set!", -- return things use title capitalization, i believe
            k_bof_downgrade = "Downgrade!",
            k_bof_sticker_applied = "Sticker Applied!",

            option_bof_appetizers = "Appetizers",
            option_bof_jesters = "Jesters",
            option_bof_normalities = "Normalities",
            option_bof_fables = "Fables"
        }
    }
}
