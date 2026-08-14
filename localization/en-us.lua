return {
    descriptions = {
        Joker = {
            -- Appetizers
            j_bof_dragonfruit = {
                name = "Dragonfruit",
                text = {
                    "Add a permanent copy",
                    "of all {C:attention}played{} cards",
                    "next hand to hand,",
                    "{C:red,E:2}self destructs"
                }
            },
            j_bof_blueberries = {
                name = "Blueberries",
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
                    "{C:red}Destroyed{} when {C:attention}Boss Blind{} is defeated"
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
            j_bof_candy = {
                name = "Pocket Candy",
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
            j_bof_tomatoes = {
                name = "Tomatoes",
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
                    "#<have,has>1# a {C:white,X:small}Small{} {C:fish}Fish{} card and a",
                    "{C:white,X:big}Big{} {C:fish}Fish{} card added to #<their,its>1# {C:attention}contents"
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
                    "if played hand is a {C:attention}Flush",
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
                    "{C:blue}+#1#{} hand#<s>1# if {C:attention}Blind{} is",
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
                        "only {C:white,X:big}Big{} {C:fish}Fish{} cards"
                    }
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
                    "This Joker gains {C:chips}+Chips",
                    "equal to the {C:attention}current Ante",
                    "when a Joker is {C:attention}sold",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chip#<s>1#)"
                }
            },
            j_bof_golden_sun = {
                name = "Mr. Golden Sun",
                text = {
                    {
                        "{C:red}Destroy{} all cards in final",
                        "{C:attention}discarded hand{} each round"
                    },
                    {
                        "Halve {C:chips}Chips{} and {C:mult}Mult{} when",
                        "calculating score for played hand"
                    }
                }
            },
            j_bof_jack_frost = {
                name = "Jack Frost",
                text = {
                    "This Joker gains {C:white,X:mult}X#1#{} Mult per",
                    "{C:attention}#2# {C:inactive}[#3#]{} chips from {C:attention}scoring",
                    "cards in played hands",
                    "{C:inactive}(Currently {C:white,X:mult}X#4#{C:inactive} Mult)"
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
                    "Create the {C:planet}Planet{} card for",
                    "discarded {C:attention}poker hand{} if it",
                    "contains a card with a {C:blue}Blue Seal",
                    "{C:inactive}(Must have room)"
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
            j_bof_furious = {
                name = "Furious Joker",
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
            j_bof_fancy = {
                name = "Fancy Pants",
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
                    "{C:red}Destroy{} each played {C:attention}#1#",
                    "and permanently decrease",
                    "{C:attention}current Blind type{}'s score",
                    "requirement by {C:attention}#2#%{} per card,",
                    "{C:attention,s:0.8}Enhancement{s:0.8} changes every round"
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
            j_bof_bouncer = {
                name = "Bouncer",
                text = {
                    "{C:mult}+#1#{} Mult if you have at",
                    "least {C:attention}#2#{} card#<s>2# with the",
                    "same {C:attention}suit{} in your {C:attention}full deck"
                }
            },
            j_bof_elephant = {
                name = "Elephant",
                text = {
                    "{C:chips}+#1#{} Chips if all",
                    "{C:attention}played{} cards are",
                    "the same {C:attention}rank"
                }
            },
            j_bof_prom_king = {
                name = "Prom King",
                text = {
                    "Played {C:attention}Kings{} give an",
                    "additional {X:mult,C:white}X#1#{} Mult",
                    "when scored per {C:attention}Queen{}",
                    "played or held in hand"
                }
            },
            j_bof_prom_queen = {
                name = "Prom Queen",
                text = {
                    "Each {C:attention}Queen{} held in hand",
                    "gives {C:chips}+#1#{} Chips per {C:attention}King{}",
                    "played or held in hand"
                }
            },
            j_bof_freeze = {
                name = "Brain Freeze",
                text = {
                    "This Joker decreases the",
                    "{C:attention}level{} of a random {C:attention}poker hand",
                    "and gains {C:white,X:mult}X#1#{} Mult every",
                    "{C:attention}other {C:planet}Planet{} card sold",
                    "{C:inactive,s:0.8}#2#",
                    "{C:inactive}(Currently {C:white,X:mult}X#3#{C:inactive} Mult)"
                }
            },
            j_bof_fnesen = {
                name = "Fnesen",
                text = {
                    {
                        "{C:debuff}Debuff{} a random {C:attention}Joker",
                        "every hand played"
                    },
                    {
                        "If this Joker is debuffed,",
                        "it instead gives {C:white,X:mult}X#1#{} Mult"
                    }
                }
            },
            j_bof_jocker = {
                name = "Jocker",
                text = {
                    {
                        "Earn {C:money}$#1#{} when a",
                        "{C:common}Common{} or {C:uncommon}Uncommon",
                        "{C:attention}Joker{} is purchased"
                    },
                    {
                        "{C:rare}Rare {C:attention}Jokers{} cost",
                        "{C:attention}double{} in the shop"
                    }
                }
            },
            j_bof_postman = {
                name = "Postman",
                text = {
                    "First {C:attention}four{} played",
                    "cards additionally",
                    "count as a {C:spades}Spade{},",
                    "{C:hearts}Heart{}, {C:clubs}Club{}, or",
                    "{C:diamonds}Diamond{} respectively"
                }
            },
            j_bof_satanist = {
                name = "Satanist",
                text = {
                    "Retrigger each {C:attention}other",
                    "played card {C:attention}once{} for",
                    "every {C:attention}6{} in played hand"
                }
            },
            j_bof_printed = {
                name = "3D-Printed Joker",
                text = {
                    "Copies abilities of all",
                    "held {C:common}Common {C:attention}Jokers"
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
            j_bof_keyboard = {
                name = "Keyboard",
                text = {
                    "Played {C:attention}8s{} give {C:mult}+#1#{} Mult",
                    "for every {C:attention}8{} in your",
                    "remaining deck when scored",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                }
            },
            j_bof_gnome = {
                name = "Card-en Gnome",
                text = {
                    "Cards with an {C:dark_edition}Edition",
                    "in the shop are {C:attention}free{}"
                }
            },
            j_bof_astrolabe = {
                name = "Astrolabe",
                text = {
                    "When a {C:planet}Planet{} card in a",
                    "{C:planet}Celestial Pack{} is used,",
                    "create a random {C:planet}Planet{} card"
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
                    "{E:1,s:1.3}?????"
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
                    "{E:1,s:1.3}?????"
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
                    "{E:1,s:1.3}?????"
                }
            },
            j_bof_taillefer = {
                name = "Taillefer",
                text = {
                    "Fill {C:attention}consumable slots",
                    "with random {C:spectral}Spectral{} cards",
                    "when {C:attention}Blind{} is selected,",
                    "{C:attention}+#1#{} consumable slot"
                },
                unlock = {
                    "{E:1,s:1.3}?????"
                }
            },
            j_bof_dagonet = {
                name = "Dagonet",
                text = {
                    "Played {C:attention}Enhanced{} cards give",
                    "{C:mult}+#1#{} Mult when scored,",
                    "increases by {C:mult}+#2#{} Mult when",
                    "a {C:attention}Enhanced{} card is discarded"
                },
                unlock = {
                    "{E:1,s:1.3}?????"
                }
            },
            j_bof_gonella = {
                name = "Gonella",
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
                    "{E:1,s:1.3}?????"
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
                        "Create a random {C:white,X:small}Small{} {C:fish}Fish{} card when {C:attention}Blind{} is selected",
                        "and a random {C:white,X:big}Big{} {C:fish}Fish{} card when {C:attention}Blind{} is defeated",
                        "if this is the {C:attention}rightmost{} Joker"
                    }
                },
                unlock = {
                    "{E:1,s:1.3}?????"
                }
            },
            j_bof_durie = {
                name = "Durie",
                text = {
                    {
                        "Pressing {C:white,X:red}Discard{} instead applies",
                        "{C:dark_edition}Negative{} to all selected cards"
                    },
                    {
                        "{C:dark_edition}Negative{} playing cards {C:red}lose",
                        "their {C:dark_edition}Edition{} at end of round"
                    }
                },
                unlock = {
                    "{E:1,s:1.3}?????"
                }
            },
            j_bof_mezzetino = {
                name = "Mezzetino",
                text = {
                    "Create a {C:dark_edition}Negative",
                    "copy of {C:planet}Planet{} card",
                    "for played hand"
                },
                unlock = {
                    "{E:1,s:1.3}?????"
                }
            },
            j_bof_beltrame = {
                name = "Beltrame",
                text = {
                    {
                        "Cards held in hand at",
                        "end of round create {C:attention}Tags",
                        "dependent on their {C:attention}suit",
                        "{C:inactive,s:0.8}(Cannot create more than {C:attention,s:0.8}#1#{C:inactive,s:0.8} Tag#<s>1# at once)"
                    },
                    {
                        "{C:spades,s:0.9}Spades{s:0.9} create {C:dark_edition,s:0.9}Polychrome Tags",
                        "{C:hearts,s:0.9}Hearts{s:0.9} create {C:red,s:0.9}Garbage Tags",
                        "{C:clubs,s:0.9}Clubs{s:0.9} create {C:planet,s:0.9}Orbital Tags",
                        "{C:diamonds,s:0.9}Diamonds{s:0.9} create {C:attention,s:0.9}Standard Tags"
                    }
                },
                unlock = {
                    "{E:1,s:1.3}?????"
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
                    "Earn an additional {C:money}$#1#{} at end",
                    "of round per held {C:attention}consumable",
                    "{C:attention}Consumables{} in shop may",
                    "rarely appear {C:dark_edition,T:e_negative}Negative"
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
                    "Start with no {C:attention}Aces{} and",
                    "an additional full rank",
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
                    "Have only one",
                    "{C:attention}suit{} in deck"
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
                    "{C:attention}Enhanced{} cards",
                    "are {C:red}destroyed",
                    "when {C:attention}discarded"
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
                    "Preview the next {C:attention}Showdown Blind",
                    "and next {C:attention}Boss Blind{} at any time",
                    "{C:inactive}(See Run Info)"
                },
                unlock = {
                    "Reroll a {C:attention}Showdown Blind{}"
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
                    "{C:chips}+#1#{} extra chips,",
                    "{s:0.8}does not count for",
                    "{C:attention,s:0.8}enhancement{s:0.8} effects"
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
            c_bof_goldfish_s = {
                name = "Goldfish {X:small}Small",
                text = {
                    "Earn {C:money}$#1#{} when hand played,",
                    "{C:attention}+#2#{} consumable slot#<s>2# while held",
                    "{C:inactive}#3# round#<s>3# remaining..."
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
            c_bof_goldfish_b = {
                name = "Goldfish {X:big}Big",
                text = {
                    "Earn {C:money}$#1#{} when hand played,",
                    "{C:attention}+#2#{} consumable slot#<s>2# while held",
                    "{C:inactive}#3# round#<s>3# remaining..."
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
            c_bof_goldfish_l = {
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
            }
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
            v_bof_shoplifting = {
                name = "Shoplifting",
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
                    "{C:attention}restock{} all present {C:attention}Booster Packs"
                }
            },
            v_bof_lottery_ticket = {
                name = "Lottery Ticket",
                text = {
                    "Every {C:attention}#<o>1#{} reroll in the shop,",
                    "{C:attention}restock{} all present {C:attention}Vouchers"
                },
                unlock = {
                    "Redeem {C:attention}2{} Vouchers",
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
        -- enemies (& finishers)
        Blind = {
            bl_bof_dominant = {
                name = "The Dominant",
                text = {
                    "Seals have",
                    "no effect"
                }
            },
            bl_bof_risk = {
                name = "The Risk",
                text = {
                    "Rightmost Joker",
                    "is disabled"
                }
            },
            bl_bof_irradiated = {
                name = "The Irradiated",
                text = {
                    "Played cards do not give",
                    "base chips when scored"
                }
            },
            bl_bof_change = {
                name = "The Change",
                text = {
                    "Enhanced cards are",
                    "drawn face down"
                }
            },
            bl_bof_tiny = {
                name = "The Tiny",
                text = {
                    "Small Blind next Ante",
                    "is unskippable and large"
                }
            },
            bl_bof_damping = {
                name = "The Damping",
                text = {
                    "All Rare Jokers are",
                    "disabled until final hand"
                }
            },
            bl_bof_viscous = {
                name = "The Viscous",
                text = {
                    "Permanently debuff one random",
                    "scoring card per hand"
                }
            },
            bl_bof_angle = {
                name = "The Angle",
                text = {
                    "Blind size increases by X0.1",
                    "per card discarded, -1 hand"
                }
            },
            bl_bof_array = {
                name = "The Array",
                text = {
                    "Destroy a consumable",
                    "when hand played"
                }
            },
            bl_bof_curve = {
                name = "The Curve",
                text = {
                    "Decrease level of",
                    "discarded poker hands"
                }
            },
            bl_bof_decay = {
                name = "The Decay",
                text = {
                    "Cards cannot",
                    "be rearranged"
                }
            },
            bl_bof_average = {
                name = "The Average",
                text = {
                    "#1# in #2# chance to discard",
                    "modified cards when drawn"
                }
            },
            bl_bof_frequent = {
                name = "The Frequent",
                text = {
                    "Cards with #1#",
                    "suit are drawn face down"
                }
            },
            bl_bof_random = {
                name = "The Random",
                text = {
                    "Shuffle cards in",
                    "played hand"
                }
            },
            bl_bof_useless = {
                name = "The Useless",
                text = {
                    "Halve the sell value",
                    "of all Jokers"
                }
            },
            bl_bof_irrational = {
                name = "The Irrational",
                text = {
                    "Shuffle cards",
                    "held in hand"
                }
            },
            bl_bof_dense = {
                name = "The Dense",
                text = {
                    "First card used in",
                    "scoring is debuffed"
                }
            },
            bl_bof_stress = {
                name = "The Stress",
                text = {
                    "Voucher cannot be",
                    "restocked next Ante"
                }
            },
            bl_bof_terminal = {
                name = "The Terminal",
                text = {
                    "Last scored rank is",
                    "debuffed next hand"
                }
            },
            bl_bof_circuit = {
                name = "The Circuit",
                text = {
                    "Only four cards may",
                    "be visible at once"
                }
            },
            bl_bof_particle = {
                name = "The Particle",
                text = {
                    "Blinds next Ante",
                    "are unskippable"
                }
            },
            bl_bof_golden = {
                name = "The Golden",
                text = {
                    "Cards held in hand at",
                    "end of round give -$3"
                }
            },
            bl_bof_square = {
                name = "The Square",
                text = {
                    "Hand must contain",
                    "4 scoring cards"
                }
            },
            bl_bof_wave = {
                name = "The Wave",
                text = {
                    "Rightmost Joker becomes",
                    "Pinned when last hand played"
                }
            },
            bl_bof_resistance = {
                name = "The Resistance",
                text = {
                    "No payout from Blind, Hands,",
                    "Discards, or Interest"
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
                    "{C:attention}#2# {C:white,X:small}Small{} {C:fish}Fish{} cards"
                }
            },
            p_bof_hooked = {
                name = "Hooked Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2# {C:white,X:big}Big{} {C:fish}Fish{} cards"
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
			},
            bof_baltrame_spades = {
                name = "Spades",
                text = {
                    "Played cards with",
                    "{C:spades}Spade{} suit create an",
                    "{C:spectral}Ethereal Tag{} when scored"
                }
            },
            bof_baltrame_hearts = {
                name = "Hearts",
                text = {
                    "Played cards with",
                    "{C:hearts}Heart{} suit create an",
                    "{C:tarot}Charm Tag{} when scored"
                }
            },
            bof_baltrame_clubs = {
                name = "Clubs",
                text = {
                    "Played cards with",
                    "{C:clubs}Clubs{} suit create an",
                    "{C:planet}Meteor Tag{} when scored"
                }
            },
            bof_baltrame_diamonds = {
                name = "Diamonds",
                text = {
                    "Played cards with",
                    "{C:diamonds}Diamond{} suit create an",
                    "{C:attention}Standard Tag{} when scored"
                }
            },
        }
    },
    misc = {
        dictionary = {
            b_fish_cards = "Fish Cards",
            k_active_ex = "Active!",
            k_inactive_el = "Inactive...",
            k_ready_ex = "Ready!",
            k_destroyed_ex = "Destroyed!",
            k_alarm_ex = "Alarm Set!",
            k_erased_ex = "Erased!",
            k_sticker_ex = "Sticker Applied!",
            k_bof_tackle = "Tackle Pack",
            k_bof_fry = "Fry Pack",
            k_bof_hooked = "Hooked Pack",
            k_fish = "Fish",
            bl_bof_square = "Must contain 4 scoring cards",
            bl_bof_terminal = "Last scored rank is debuffed",
            bof_most_common_suit = "(most common suit in deck)",

            bof_bof = "Bundles Of Fun",
            bof_appetizers = "Appetizers",
            bof_jesters = "Jesters",
            bof_normalities = "Normalities",
            bof_fables = "Fables",
            bof_flats = "Flats",
            bof_minnows = "Minnows",
            bof_coupons = "Coupons",
            bof_enemies = "Enemies",
            -- bof_finishers = "Finishers",
            -- bof_games = "Games"
        }
    }
}