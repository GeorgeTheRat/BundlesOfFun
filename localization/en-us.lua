return {
    descriptions = {
        Joker = {
            -- Appetizers
            j_bof_dragonfruit = {
                name = "Dragonfruit",
                text = {
                    "Add a permanent copy of all",
                    "{C:attention}played{} cards next hand to deck",
                    "or destroy all cards in",
                    "next {C:attention}discarded{} poker hand",
                    "{C:red,E:2}self destructs"
                }
            },
            j_bof_blueberry = {
                name = "Blueberry",
                text = {
                    "Each {C:attention}card{} held in hand",
                    "permanently gains {C:chips}+#1#{} Chip#<s>1#,",
                    "decreases by {C:chips}-#2#{} Chip#<s>2#",
                    "at end of round"
                }
            },
            j_bof_grapes = {
                name = "Grapes",
                text = {
                    "{C:chips}+#1#{} Chip#<s>1#, {C:mult}+#2#{} Mult, {C:white,X:mult}X#3#{} Mult",
                    "Destroyed when {C:attention}Boss Blind{} is defeated"
                }
            },
            j_bof_leek = {
                name = "Leek",
                text = {
                    "Increase all {C:attention}listed",
                    "{C:green,E:1}probabilities{} by {C:green}+#1#{},",
                    "decreases by {C:red}-#2#{} when",
                    "a {C:green}probability{} succeeds",
                }
            },
            j_bof_durian = {
                name = "Durian",
                text = {
                    "Sell this Joker to",
                    "fill {C:attention}consumable slots",
                    "with {C:tarot}The Fool"
                }
            },
            j_bof_bread = {
                name = "Wonderous Bread",
                text = {
                    "Balance {C:white,X:plasma}#1#%{} of {C:chips}Chips{} and {C:mult}Mult{},",
                    "decreases by {C:white,X:plasma}-#2#%{} at end of round"
                }
            },
            j_bof_beans = {
                name = "Jelly Beans",
                text = {
                    "The next {C:attention}#1# Blind#<s>1#{} skipped,",
                    "create a {C:attention}Juggle Tag"
                }
            },
            j_bof_apple = {
                name = "Apple",
                text = {
                    "Each scored card",
                    "permanently gains {C:mult}+#1#{} Mult,",
                    "decreases by {C:mult}-#2#{} Mult",
                    "at end of round"
                }
            },
            j_bof_core = {
                name = "Apple Core",
                text = {
                    "The next {C:attention}#1#{} played",
                    "cards give {C:mult}+#2#{} Mult",
                    "instead of scoring"
                }
            },
            j_bof_tomato = {
                name = "Tomato",
                text = {
                    "The next {C:attention}#1#{} cards",
                    "held in hand have a",
                    "{C:green}#2# in #3#{} chance of becoming",
                    "{C:attention}Mult Cards{} or {C:attention}Lucky Cards"
                }
            },
            j_bof_shrimp = {
                name = "Fried Shrimp",
                text = {
                    "The next {C:attention}#1#{} Booster Pack#<s>1# opened",
                    "#<have,has>1# a {C:white,E:1,X:small}Small{} {C:fish}Fish{} card and a",
                    "{C:white,E:1,X:big}Big{} {C:fish}Fish{} card added to #<their,its>1# {C:attention}contents"
                }
            },
            -- Jesters
            j_bof_hal = {
                name = "Hatty Hal",
                text = {
                    "This Joker gains {C:chips}+#1#{} Chip#<s>1# and",
                    "increases its {C:attention}scaling{} by",
                    "{C:chips}+#2#{} Chip#<s>2# when a {C:attention}playing card",
                    "is added to your deck",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chip#<s>3#)"
                }
            },
            j_bof_henry = {
                name = "Handy Henry",
                text = {
                    "Earn an additional {C:money}$#1#",
                    "per {C:attention}remaining {C:blue}Hand{} at",
                    "the end of each round"
                }
            },
            j_bof_tom = {
                name = "Tumor Tom",
                text = {
                    "{C:dark_edition}+#1#{} Joker slot#<s>1#,",
                    "{C:red}-#2#{} consumable slot#<s>2#"
                }
            },
            j_bof_barber = {
                name = "Barber",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "gain {C:mult}+#1#{} Mult and",
                    "remove {C:attention}Enhancement{} of",
                    "{C:attention}#2#{} random card#<s>2# in deck",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
                }
            },
            j_bof_ballbo = {
                name = "Ballbo",
                text = {
                    "This Joker gains {C:mult}+#1#{} Mult and",
                    "increases its {C:attention}scaling{} by {C:mult}+#2#{} Mult",
                    "if played hand contains a {C:attention}Flush",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
                }
            },
            j_bof_rogue = {
                name = "Rogue",
                text = {
                    "Cards with {C:spades}Spade",
                    "or {C:clubs}Club{} suit give",
                    "{C:money}$#1#{} when held in hand",
                    "at end of round"
                }
            },
            j_bof_eddrick = {
                name = "Evil Eddrick",
                text = {
                    "{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
                    "on {C:attention}final hand{} of round"
                }
            },
            j_bof_super = {
                name = "Super Joker",
                text = {
                    "{C:blue}+#1#{} hands if {C:attention}Blind{} is",
                    "not won by {C:attention}final hand",
                    "{C:inactive,s:0.8}(May only trigger once per round)"
                }
            },
            j_bof_eureka = {
                name = "Emmanuel E. \"Eureka\"",
                text = {
                    {
                        "{C:tarot}Arcana Packs{} may contain",
                        "{C:attention}consumables{} of all types"
                    },
                    {
                        "{C:spectral}Spectral Packs{} and {C:planet}Celestial Packs",
                        "may contain {C:tarot}Tarot{} cards"
                    },
                    {
                        "{C:fish}Tackle Packs{} always contain",
                        "only {C:white,E:1,X:big}Big{} {C:fish}Fish{} cards"
                    },
                    -- {
                    --     "{C:attention}Unenhanced{} cards in",
                    --     "{C:attention}Standard Packs{} become {C:attention}Wooden{}"
                    -- }
                }
            },
            j_bof_matey = {
                name = "Matey",
                text = {
                    "{C:white,E:1,X:big}Big{} {C:fish}Fish{} cards turn",
                    "into their respective",
                    "{C:white,E:1,X:small}Small{} {C:fish}Fish{} card",
                    "instead of expiring"
                }
            },
            j_bof_timmy = {
                name = "Youngster Timmy",
                text={
                    "{C:blue}+#1#{} Chip#<s>1# for each",
                    "card above {C:attention}#2#",
                    "in your full deck",
                    "{C:inactive}(Currently {C:blue}+#3#{C:inactive} Chip#<s>3#)"
                },
            },
            j_bof_gary = {
                name = "Geezer Gary",
                text = {
                    "This Joker gains {C:chips}+#1#{} Chip#<s>1#",
                    "when a Joker is {C:attention}sold{},",
                    "increases by {C:chips}+#2#{} Chip#<s>2# when",
                    "{C:attention}Boss Blind{} is defeated",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chip#<s>3#)"
                }
            },
            j_bof_golden_sun = {
                name = "Mr. Golden Sun",
                text = {
                    "Halve base {C:chips}Chips{} and {C:mult}Mult",
                    "{C:red}Destroy{} all cards",
                    "in final {C:attention}discarded",
                    "{C:attention}poker hand{} each round"
                }
            },
            j_bof_jack_frost = {
                name = "Jack Frost",
                text = {
                    "{C:mult}+#1#{} Mult if played",
                    "{C:attention}poker hand{} has",
                    "not already been ",
                    "played this round"
                }
            },
            j_bof_jim = {
                name = "Slim Jim",
                text = {
                    "{C:blue}+#1#{} hand per round",
                    "{C:red}+#2#{} discard each round",
                    "{C:attention}#3#{} hand size"
                }
            },
            j_bof_gumphrey = {
                name = "Gumphrey",
                text = {
                    "{C:mult}+#1#{} Mult for every",
                    "{C:attention}Enhanced{} card in",
                    "your {C:attention}full deck",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                }
            },
            j_bof_soothsayer = {
                name = "Soothsayer",
                text = {
                    {
                        "Creates a {C:tarot}Tarot{} card if a",
                        "card with a {C:purple}Purple Seal{} is",
                        "held in hand at end of round",
                    },
                    {
                        "Upgrade level of discarded",
                        "{C:attention}poker hand{} if discarded hand",
                        "contains {C:attention}#1#{} cards with {C:blue}Blue Seals",
                    },
                },
            },
            j_bof_polymath = {
                name = "Polymath",
                text = {
                    "Each card scored and held in hand",
                    "has a {C:green}#1# in #2#{} chance to give",
                    "{C:chips}+#3#{} Chip#<s>3#, {C:mult}+#4#{} Mult, {C:white,X:mult}X#5#{} Mult, and {C:money}$#6#"
                }
            },
            j_bof_luminary = {
                name = "Luminary",
                text = {
                    "Earn {C:money}$#1#{} at end of round",
                    "Increase payout by {C:money}$#2#{} for each",
                    "played hand that contains a",
                    "{C:attention}played{} and {C:attention}unscoring{} card with",
                    "{C:hearts}Heart{} or {C:diamonds}Diamond{} suit this round"
                }
            },
            j_bof_felix = {
                name = "Furious Felix",
                text = {
                    "Earn {C:money}$#1#{} at",
                    "end of round",
                    "Earn no {C:attention}interest"
                }
            },
            j_bof_larry = {
                name = "Laggard Larry",
                text = {
                    "Earn {C:money}$#1#{} when",
                    "{C:attention}first{} or {C:attention}last hand",
                    "of round is played"
                }
            },
            j_bof_phony = {
                name = "Phony",
                text = {
                    "{C:mult}+#1#{} Mult",
                    "{C:chips}-#2#{} Chips"
                }
            },
            j_bof_frank = {
                name = "Frank Fop",
                text = {
                    "Create either a {C:attention}Handy Tag{} or",
                    "{C:attention}Garbage Tag{} at random when",
                    "{C:small,E:1}Small Blind{} is selected"
                }
            },
            j_bof_crafted = {
                name = "Crafted Joker",
                text = {
                    "If played hand is the {C:attention}first{} hand",
                    "of round, copy all {C:attention}modifications{}",
                    "from the {C:attention}leftmost{} card to the",
                    "{C:attention}rightmost{} card in played hand,",
                    "then {C:red}destroy{} the leftmost card"
                }
            },
            j_bof_schlitzohr = {
                name = "Schlitzohr",
                text = {
                    "Randomize the {C:attention}rank{} of",
                    "the {C:attention}#1#{} lowest ranked",
                    "cards in your deck",
                    "when {C:attention}Blind{} is selected"
                }
            },
            j_bof_hotboxer = {
                name = "Hotboxer",
                text = {
                    {
                        "{C:attention}+#1#{} shop slot#<s>1#",
                        "The {C:attention}rightmost{} shop slot",
                        "contains only {C:tarot}Tarot{} cards"
                    },
                    {
                        "Decreases {C:attention}sell value{} by {C:money}$#2#",
                        "per {C:tarot}Tarot{} card purchased"
                    }
                }
            },
            j_bof_director = {
                name = "Director",
                text = {
                    "{C:white,X:mult}X#1#{} Mult, retriggers",
                    "{C:attention}once{} for every card in",
                    "played hand that {C:attention}retriggered"
                }
            },
            j_bof_zeke = {
                name = "Zipper Zeke",
                text = {
                    "{C:green}#1# in #2#{} chance to create",
                    "a non-{C:common}Common{} Joker when",
                    "a {C:tarot}Tarot{} card is {C:attention}sold",
                    "{C:inactive}(Must have room)"
                }
            },
            j_bof_laughing_stock = {
                name = "Laughing Stock",
                text = {
                    "{C:red}Destroy{} each played card with",
                    "a {C:attention}seal{} and permanently",
                    "decrease the {C:attention}current Blind type{}'s",
                    "score requirement by {C:attention}#1#%{} per card",
                    "{C:inactive}(Multiplicative)"
                }
            },
            j_bof_angler = {
                name = "Angler",
                text = {
                    {
                        "{C:chips}+#1#{} Chips per {C:fish}Fish{} card held",
                        "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chip#<s>2#)"
                    },
                    {
                        "{C:mult}+#3#{} Mult per {C:fish}Fish{} card expired",
                        "{C:inactive}(Currently {C:mult}+#4#{C:inactive} Mult)"
                    }
                }
            },
            j_bof_pianoman = {
                name = "Pianoman",
                text = {
                    "Only {C:common}Common {C:attention}Jokers",
                    "may appear in the shop",
                    "You may select {C:attention}unlimited",
                    "cards in {C:attention}Booster Packs"
                }
            },
            -- Normalities
            j_bof_notebook = {
                name = "Notebook",
                text = {
                    {
                        "Apply a {C:dark_edition}sticker{} to",
                        "a random Joker",
                        "when {C:attention}Blind{} is selected"
                    },
                    {
                        "Remove two {C:dark_edition}stickers",
                        "and earn {C:money}$#1#",
                        "when {C:attention}Boss Blind",
                        "is defeated"
                    }
                }
            },
            j_bof_eraser = {
                name = "Eraser",
                text = {
                    "All cards held in hand give",
                    "{C:mult}+#1#{} Mult but {C:red}lose{} any",
                    "{C:attention}modifications{} they have"
                }
            },
            j_bof_rummikub = {
                name = "Rummikub Tile",
                text = {
                    "This {C:attention}Joker{} gains {C:chips}+#1#{} Chip#<s>1#",
                    "if the {C:attention}total{} chip value of ",
                    "played cards is at least {C:attention}#2#",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chip#<s>3#)"
                }
            },
            j_bof_passport = {
                name = "Passport",
                text = {
                    {
                        "This Joker gains {C:chips}+#1#{} Chip#<s>1#",
                        "per {C:attention}unique Blind{} defeated",
                        "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chip#<s>2#)"
                    },
                    {
                        "{C:attention}Boss Blinds{} may",
                        "appear multiple times"
                    }
                }
            },
            j_bof_clock_inactive = {
                name = "Alarm Clock",
                text = {
                    "{X:mult,C:white}X#1#{} Mult every",
                    "{C:attention}other{} hand",
                    "{C:inactive}Inactive...",
                }
            },
            j_bof_clock_active = {
                name = "Alarm Clock",
                text = {
                    "{X:mult,C:white}X#1#{} Mult every",
                    "{C:attention}other{} hand",
                    "{C:inactive,E:bof_alarm}Active!",
                }
            },
            j_bof_billy_bass = {
                name = "Big Mouth Billy Bass",
                text = {
                    "Retrigger all {C:attention}held{}",
                    "{C:fish}Fish{} card abilities"
                }
            },
            j_bof_fish_bowl = {
                name = "Fish in a Bowl",
                text = {
                    "Gains {C:money}$#1#{} of sell value",
                    "at end of round",
                    "{C:green}#2# in #3#{} chance to {C:red}die{} instead,",
                    "retaining this Joker's {C:attention}sell value"
                }
            },
            j_bof_dead_fish_bowl = {
                name = "Dead Fish in a Bowl",
                text = {
                    "Creates a {C:white,E:1,X:small}Small{} {C:attention}Goldfish{} and loses",
                    "{C:money}$#1#{} of sell value at end of round",
                    "This card is {C:red}destroyed{} when",
                    "its {C:attention}sell value{} reaches {C:money}$#2#"
                }
            },
            -- Fables
            j_bof_narr = {
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
            j_bof_manqian = {
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
            j_bof_turold = {
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
            j_bof_taillefer = {
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
            j_bof_dagonet = {
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
            },
            j_bof_shennong = {
                name = "Shennong",
                text = {
                    {
                        "{C:attention}Bottommost{} card in deck becomes a",
                        "{C:attention}Lucky Card{} when {C:attention}Blind{} is selected",
                    },
                    {
                        "All {C:attention}listed {C:green,E:1}probabilities{} are",
                        "{C:green}guaranteed{} during the {C:attention}Boss Blind"
                    }
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_nuwa_fuxi = {
                name = "Nüwa & Fuxi",
                text = {
                    {
                        "Create a random {C:tarot}Tarot{} card when {C:attention}Blind{} is selected and",
                        "a random {C:dark_edition}Negative {C:tarot}Tarot{} card when {C:attention}Blind{} is defeated",
                        "if this is the {C:attention}leftmost{} Joker",
                        "{C:inactive}(Must have room)"
                    },
                    {
                        "Create a random {C:white,E:1,X:small}Small{} {C:fish}Fish{} card when {C:attention}Blind{} is selected",
                        "and a random {C:white,E:1,X:big}Big{} {C:fish}Fish{} card when {C:attention}Blind{} is defeated",
                        "if this is the {C:attention}rightmost{} Joker"
                    }
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            }
        },
        -- flats
        Back = {
            b_bof_embroidered = {
                name = "Embroidered Deck",
                text = {
                    "Start with one random",
                    "{C:attention}rank{} missing from deck",
                    "When {C:attention}Boss Blind{} is defeated,",
                    "add {C:attention}4{} cards to deck with each",
                    "{C:attention}suit{} of one random {C:attention}rank",
                    "{C:inactive,s:0.8}(ex: {C:attention,s:0.8}K of Spades{C:inactive,s:0.8}, {C:attention,s:0.8}Hearts{C:inactive,s:0.8}, {C:attention,s:0.8}Clubs{C:inactive,s:0.8}, and {C:attention,s:0.8}Diamonds{C:inactive,s:0.8})"
                },
                unlock = {
                    "Have {C:attention}80{} or more",
                    "cards in your deck"
                }
            },
            b_bof_flannel = {
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
            b_bof_illusion = {
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
            b_bof_fossilized = {
                name = "Fossilized Deck",
                text = {
                    "Earn an additional {C:money}$#1#{} at",
                    "end of round per held {C:attention}consumable",
                    "{C:attention}Consumables{} in shop may",
                    "rarely appear {C:dark_edition}Negative"
                },
                unlock = {
                    "Have one of each",
                    "{C:attention}base consumable type",
                    "in consumable slots"
                }
            },
            b_bof_wooden = {
                name = "Wooden Deck",
                text = {
                    "Start with no {C:attention}Aces{}",
                    "and an additional full rank",
                    "of {C:attention}2s{}, {C:attention}3s{}, {C:attention}4s{}, and {C:attention}5s",
                    "All cards start {C:attention,T:m_bof_wooden}Wooden"
                },
                unlock = {
                    "Destroy {C:attention}4 Aces",
                    "in one round"
                }
            },
            b_bof_backgammon = {
                name = "Backgammon Deck",
                text = {
                    "Convert each scored card with",
                    "{C:spades}Spade{} or {C:clubs}Club{} suit into {C:hearts}Heart{}",
                    "or {C:diamonds}Diamond{} suit and vice versa",
                    "No effect if Joker slots are full"
                },
                unlock = {
                    "Have exactly {C:attention}10{} cards of",
                    "each suit in your deck"
                }
            },
            b_bof_scaly = {
                name = "Scaly Deck",
                text = {
                    "Start run with the",
                    "{C:attention,T:v_bof_ice_bucket}Ice Bucket{} voucher and",
                    "{C:attention}2{} copies of {C:fish,T:c_bof_octopus_b}Octopus {C:white,E:1,X:big}Big"
                },
                unlock = {
                    "Discover a",
                    "{C:white,E:1,X:legendary}Legendary{} {C:fish}Fish{} card"
                }
            },
            b_bof_retro = {
                name = "Retro Deck",
                text = {
                    "Increase the level of",
                    "{C:attention}#1#{} random {C:attention}poker hands",
                    "when {C:attention}Blind{} is skipped"
                },
                unlock = {
                    "Play all {C:attention}poker hands",
                    "at least once in one run"
                }
            },
            b_bof_soapy = {
                name = "Soapy Deck",
                text = {
                    "{C:attention}Enhanced{} cards are",
                    "destroyed when {C:attention}discarded"
                },
                unlock = {
                    "Destroy a card with",
                    "an {C:enhanced}Enhancement{},",
                    "{C:dark_edition}Edition{}, and {C:attention}Seal"
                }
            },
            b_bof_display = {
                name = "Display Deck",
                text = {
                    "Start with all {C:attention}ranks{} of one {C:attention}suit",
                    "When {C:attention}Boss Blind{} defeated,",
                    "add a copy of every {C:attention}rank",
                    "of a random {C:attention}suit{} to deck"
                },
                unlock = {
                    "Have only one",
                    "{C:attention}rank{} in deck"
                }
            },
            b_bof_lightning = {
                name = "Lightning Deck",
                text = {
                    "{C:attention}Face{} cards start",
                    "as {C:attention}Mult Cards",
                    "Played cards do not give",
                    "their {C:attention}base chips{} when scored"
                },
                unlock = {
                    "Win a run without ever",
                    "triggering any {C:mult}+Mult{} effects,",
                    "{C:white,s:0.8,X:mult}XMult{s:0.8} may still be used"
                }
            }
        },
        -- wooden (for, what do you know, wooden deck)
        Enhanced = {
            m_bof_wooden = {
                name = "Wooden",
                text = {
                    "{C:chips}+#1#{} extra chips"
                }
            }
        },
        -- fih
        Fish = {
            c_bof_bass_s = {
                name = "Largemouth Bass {X:small}Small",
                text = {
                    "{C:chips}+#1#{} Chips,",
                    "{C:attention}+#2#{} consumable slot#<s>2# while held",
                    "{C:inactive}#3# round#<s>3# remaining..."
                }
            },
            c_bof_betta_s = {
                name = "Betta {X:small}Small",
                text = {
                    "{C:mult}+#1#{} Mult,",
                    "{C:attention}+#2#{} consumable slot#<s>2# while held",
                    "{C:inactive}#3# round#<s>3# remaining..."
                }
            },
            c_bof_trout_s = {
                name = "Rainbow Trout {X:small}Small",
                text = {
                    "{C:white,X:mult}X#1#{} Mult,",
                    "{C:attention}+#2#{} consumable slot#<s>2# while held",
                    "{C:inactive}#3# round#<s>3# remaining..."
                }
            },
            c_bof_gold_s = {
                name = "Goldfish {X:small}Small",
                text = {
                    "Earn {C:money}$#1#{} when hand played,",
                    "{C:attention}+#2#{} consumable slot#<s>2# while held",
                    "{C:inactive}#3# round#<s>3# remaining..."
                }
            },
            c_bof_koi_s = {
                name = "Koi {X:small}Small",
                text = {
                    "Balance {C:white,X:plasma}#1#%{} of {C:chips}Chips{} and {C:mult}Mult{},",
                    "{C:attention}+#2#{} consumable slot#<s>2# while held",
                    "{C:inactive}#3# round#<s>3# remaining..."
                }
            },
            c_bof_clown_s = {
                name = "Clownfish {X:small}Small",
                text = {
                    "Create a {C:common}Common{} {C:attention}Joker{} when hand played,",
                    "{C:inactive,s:0.8}(Must have room)",
                    "{C:attention}+#1#{} consumable slot#<s>1# while held",
                    "{C:inactive}#2# round#<s>2# remaining..."
                }
            },
            c_bof_blob_s = {
                name = "Blobfish {X:small}Small",
                text = {
                    "Create a {C:planet}Planet{} card when hand played,",
                    "{C:inactive,s:0.8}(Must have room)",
                    "{C:attention}+#1#{} consumable slot#<s>1# while held",
                    "{C:inactive}#2# round#<s>2# remaining..."
                }
            },
            c_bof_octopus_s = {
                name = "Octopus {X:small}Small",
                text = {
                    "Create a {C:white,E:1,X:small}Small{} copy of",
                    "the next expired {C:fish}Fish{} card,",
                    "{C:attention}+#1#{} consumable slot#<s>1# while held",
                    "{C:red,E:2}self destructs"
                }
            },
            c_bof_bass_b = {
                name = "Largemouth Bass {X:big}Big",
                text = {
                    "{C:chips}+#1#{} Chips,",
                    "{C:attention}+#2#{} consumable slot#<s>2# while held",
                    "{C:inactive}#3# round#<s>3# remaining..."
                }
            },
            c_bof_betta_b = {
                name = "Betta {X:big}Big",
                text = {
                    "{C:mult}+#1#{} Mult,",
                    "{C:attention}+#2#{} consumable slot#<s>2# while held",
                    "{C:inactive}#3# round#<s>3# remaining..."
                }
            },
            c_bof_trout_b = {
                name = "Rainbow Trout {X:big}Big",
                text = {
                    "{C:white,X:mult}X#1#{} Mult,",
                    "{C:attention}+#2#{} consumable slot#<s>2# while held",
                    "{C:inactive}#3# round#<s>3# remaining..."
                }
            },
            c_bof_gold_b = {
                name = "Goldfish {X:big}Big",
                text = {
                    "Earn {C:money}$#1#{} when hand played,",
                    "{C:attention}+#2#{} consumable slot#<s>2# while held",
                    "{C:inactive}#3# round#<s>3# remaining..."
                }
            },
            c_bof_koi_b = {
                name = "Koi {X:big}Big",
                text = {
                    "Balance {C:white,X:plasma}#1#%{} of {C:chips}Chips{} and {C:mult}Mult{},",
                    "{C:attention}+#2#{} consumable slot#<s>2# while held",
                    "{C:inactive}#3# round#<s>3# remaining..."
                }
            },
            c_bof_clown_b = {
                name = "Clownfish {X:big}Big",
                text = {
                    "Create an {C:uncommon}Uncommon{} {C:attention}Joker{} when hand played,",
                    "{C:inactive,s:0.8}(Must have room)",
                    "{C:attention}+#1#{} consumable slot#<s>1# while held",
                    "{C:inactive}#2# round#<s>2# remaining..."
                }
            },
            c_bof_blob_b = {
                name = "Blobfish {X:big}Big",
                text = {
                    "Create a {C:tarot}Tarot{} card when hand played,",
                    "{C:inactive,s:0.8}(Must have room)",
                    "{C:attention}+#1#{} consumable slot#<s>1# while held",
                    "{C:inactive}#2# round#<s>2# remaining..."
                }
            },
            c_bof_octopus_b = {
                name = "Octopus {X:big}Big",
                text = {
                    "Create a {C:white,E:1,X:big}Big{} copy of",
                    "the next expired {C:fish}Fish{} card,",
                    "{C:attention}+#1#{} consumable slot#<s>1# while held",
                    "{C:red,E:2}self destructs"
                }
            },
            c_bof_bass_l = {
                name = "Largemouth Bass {X:legendary}Legendary",
                text = {
                    "Gives {C:chips}+Chips{} equal to the {C:attention}total{} number",
                    "of chips that {C:attention}all cards{} in deck add to,",
                    "{C:attention}+#1#{} consumable slot#<s>1# while held"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            c_bof_betta_l = {
                name = "Betta {X:legendary}Legendary",
                text = {
                    "Gives {C:mult}+Mult{} equal to the",
                    "{C:attention}total{} Mult that all visible",
                    "{C:attention}poker hands{} add to,",
                    "{C:attention}+#1#{} consumable slot#<s>1# while held"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            c_bof_trout_l = {
                name = "Rainbow Trout {X:legendary}Legendary",
                text = {
                    "Jokers and {C:attention}other{} consumables",
                    "each give {C:white,X:mult}X#1#{} Mult,",
                    "{C:attention}+#2#{} consumable slot while held"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            c_bof_gold_l = {
                name = "Goldfish {X:legendary}Legendary",
                text = {
                    "Earn money equal to the",
                    "{C:attention}current amount{} of {C:attention}interest{} that",
                    "would be earned when hand played,",
                    "{C:attention}+#1#{} consumable slot#<s>1# while held"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            c_bof_koi_l = {
                name = "Koi {X:legendary}Legendary",
                text = {
                    "Balance {C:chips}Chips{} and {C:mult}Mult{},",
                    "{C:attention}+#1#{} consumable slot#<s>1# while held",
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            c_bof_clown_l = {
                name = "Clownfish {X:legendary}Legendary",
                text = {
                    "Create a non-{C:common}Common{} {C:attention}Joker{} when hand played,",
                    "{C:inactive,s:0.8}(Must have room)",
                    "{C:attention}+#1#{} consumable slot#<s>1# while held"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            c_bof_blob_l = {
                name = "Blobfish {X:legendary}Legendary",
                text = {
                    "Create a {C:spectral}Spectral{} card when hand played,",
                    "{C:inactive,s:0.8}(Must have room)",
                    "{C:attention}+#1#{} consumable slot#<s>1# while held"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            c_bof_octopus_l = {
                name = "Octopus {X:legendary}Legendary",
                text = {
                    "Create a {C:white,E:1,X:legendary}Legendary{} copy of",
                    "the next expired {C:fish}Fish{} card,",
                    "{C:attention}+#1#{} consumable slot#<s>1# while held",
                    "{C:red,E:2}self destructs"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
        },
        -- coupons
        Voucher = {
            v_bof_dark_alley = {
                name = "Dark Alley",
                text = {
                    {
                        "{C:attention}Consumables{} in shop may",
                        "rarely appear {C:dark_edition}Negative"
                    },
                    {
                        "{C:spectral}Spectral{} cards may rarely",
                        "appear in the shop"
                    }
                }
            },
            v_bof_illegal_wares = {
                name = "Illegal Wares",
                text = {
                    "{C:spectral}Spectral{} cards,",
                    "{C:dark_edition}Negative{} consumables,",
                    "and {C:dark_edition}Negative{} Jokers",
                    "appear {C:attention}3X{} more often"
                },
                unlock = {
                    "Have at least",
                    "{C:attention}3 {C:spectral}Spectral{} cards",
                    "at the same time"
                }
            },
            v_bof_unboxing = {
                name = "Unboxing",
                text = {
                    "{C:attention}Booster Packs{} may",
                    "appear in shop slots"
                }
            },
            v_bof_scalping = {
                name = "Scalping",
                text = {
                    "{C:attention}Vouchers{} may rarely",
                    "appear in shop slots"
                },
                unlock = {
                    "Skip a total of",
                    "{C:attention}30{} Booster Packs",
                    "{C:inactive}(#1#)"
                }
            },
            v_bof_scratch_off = {
                name = "Scratch-Off",
                text = {
                    "Every {C:attention}#<o>1#{} reroll in the shop,",
                    "{C:attention}restock{} all present {C:attention}Vouchers"
                }
            },
            v_bof_lottery_ticket = {
                name = "Lottery Ticket",
                text = {
                    "Every {C:attention}#<o>1#{} reroll in the shop,",
                    "{C:attention}restock{} all present {C:attention}Booster Packs"
                },
                unlock = {
                    "Redeem {C:attention}3{} Vouchers",
                    "in the same Ante"
                }
            },
            v_bof_ice_bucket = {
                name = "Ice Bucket",
                text = {
                    "{C:fish}Fish{} cards last",
                    "an {C:attention}additional{} round"
                }
            },
            v_bof_buried_treasure = {
                name = "Buried Treasure",
                text = {
                    "{C:fish}Fish{} cards give an",
                    "{C:attention}additional{} consumable slot"
                },
                unlock = {
                    "Have {C:attention}5 {C:fish}Fish",
                    "cards expire",
                    "in one run"
                }
            }
        },
        Other = {
            p_bof_tackle_normal = {
                name = "Tackle Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2# {C:fish}Fish{} cards"
                }
            },
            p_bof_tackle_jumbo = {
                name = "Jumbo Tackle Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2# {C:fish}Fish{} cards"
                }
            },
            p_bof_fry = {
                name = "Fry Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2# {C:white,E:1,X:small}Small{} {C:fish}Fish{} cards"
                }
            },
            p_bof_hooked = {
                name = "Hooked Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2# {C:white,E:1,X:big}Big{} {C:fish}Fish{} cards"
                }
            },
            k_bof_perkeo_legendary = {
                name = "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
                text = {
                    "{C:inactive,s:0.8}(Cannot copy {C:white,s:0.8,X:legendary}Legendary{C:inactive,s:0.8} Fish)"
                }
            },
            k_bof_tom_sell = {
                text = {
                    "{C:inactive,s:0.8}(Cannot be sold when slots are full)"
                }
            },
            k_bof_modification = {
				name = "Modification",
				text = {
					"{C:enhanced}Enhancement{},",
                    "{C:dark_edition}Edition{}, {C:attention}Seal"
				}
			}
        }
    },
    misc = {
        dictionary = {
            b_fish_cards = "Fish Cards",
            k_bof_active = "Active!",
            k_bof_inactive = "Inactive...",
            k_bof_ready = "Ready!",
            k_bof_destroyed = "Destroyed!",
            k_bof_alarm = "Alarm Set!",
            k_bof_downgrade = "Downgrade!",
            k_plus_fish = "+1 Fish",
            k_erased = "Erased!",
            k_bof_sticker_applied = "Sticker Applied!",
            k_bof_expired = "Expired!",
            k_bof_tackle = "Tackle Pack",
            k_bof_fry = "Fry Pack",
            k_bof_hooked = "Hooked Pack",
            k_fish = "Fish",
            k_fish_q = "Fish?",

            option_bof_appetizers = "Appetizers",
            option_bof_jesters = "Jesters",
            option_bof_normalities = "Normalities",
            option_bof_fables = "Fables",
            option_bof_flats = "Flats",
            option_bof_fish = "Fish",
            option_bof_coupons = "Coupons",
            -- option_bof_enemies = "Enemies",
            -- option_bof_finishers = "Finishers",
            -- option_bof_games = "Games"
        }
    }
}

