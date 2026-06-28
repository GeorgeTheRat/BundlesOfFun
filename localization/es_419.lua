return {
    descriptions = {
        Joker = {
            j_bof_apple = {
                name = "Manzana",
                text = {
                    "Cada carta anotada",
                    "gana {C:mult}+#1#{} Multi",
                    "se reduce en {C:attention}#2#{} al",
                    "final de la ronda",
                }
            },
            j_bof_blueberry = {
                name = "Arándano",
                text = {
                    "Cada {C:attention}carta{} en la mano",
                    "gana {C:chips}+#1#{} Ficha#<s>1#",
                    "se reduce en {C:chips}-#2#{} Ficha#<s>2#",
                    "al final de la ronda"
                }
            },
            j_bof_grapes = {
                name = "Uvas",
                text = {
                    "{C:chips}+#1#{} Ficha#<s>1#, {C:mult}+#2#{} Multi",
                    "{C:white,X:mult}X#3#{} Multi, se destruye",
                    "al derrotar una {C:attention}Ciega Jefe{}"
                }
            },
            j_bof_durian = {
                name = "Durián",
                text = {
                    "Vende este comodín para llenar",
                    "las ranuras de {C:attention}consumibles{}",
                    "con {C:tarot}El Loco{}"
                }
            },
            j_bof_apple_core = {
                name = "Corazón de manzana",
                text = {
                    "Las siguientes {C:attention}#1#{}",
                    "cartas otorgan {C:mult}+#2#{} Multi",
                    "en lugar de anotar"
                }
            },
            j_bof_dragonfruit = {
                name = "Pitahaya",
                text = {
                    "{C:attention}Copia{} todas las cartas en",
                    "la siguiente mano {C:blue}jugada{},",
                    "o {C:attention}destruye{} todas las cartas",
                    "en el siguiente {C:red}descarte{}"
                }
            },
            j_bof_jelly_beans = {
                name = "Grajeas",
                text = {
                    "Las siguientes {C:attention}2{}",
                    "{C:attention}Ciegas{} saltadas crean una",
                    "{C:attention}Etiqueta de malabar{}",
                }
            },
            j_bof_leek = {
                name = "Puerro",
                text = {
                    "Aumenta todas las {C:green,E:1}probabilidades{}",
                    "{C:attention}listadas{} en {C:green}+#1#{},",
                    "disminuye en {C:red}-#2#{} cuando",
                    "una {C:green}probabilidad{} tiene éxito",
                }
            },
            j_bof_shrimp = {
                name = "Camarón frito",
                text = {
                    "{C:mult}Evita la muerte{}",
                    "si las fichas anotadas son",
                    "al menos {C:attention}#1#%{} de las requeridas",
                    "{C:inactive}({C:attention}#2#%{C:inactive} menos cada ronda)",
                    "{C:mult}Se autodestruye"
                }
            },
            j_bof_tomato = {
                name = "Tomate",
                text = {
                    "Las siguientes {C:attention}#1#{} cartas",
                    "en la mano tienen una prob. de",
                    "{C:green}#2# en #3#{} de volverse cartas",
                    "{C:attention}Multi{} o {C:attention}de la Suerte{}"
                }
            },
            j_bof_wonderous_bread = {
                name = "Pan maravilloso",
                text = {
                    "Balancea un {C:white,X:plasma}#1#%{} de {C:chips}Fichas{}",
                    "y {C:mult}Multi{}, disminuye en {C:white,X:plasma}-#2#%{}",
                    "al final de la ronda"
                }
            },
            j_bof_hal = {
                name = "Sergio Sombredero",
                text = {
                    "Gana {C:chips}+#1#{} Fichas",
                    "y aumenta en {C:chips}+#2#{} Ficha",
                    "cada vez que se añade una",
                    "{C:attention}Carta de juego{} a tu baraja.",
                    "{C:inactive}(Actualmente {C:chips}+#3#{C:inactive} Fichas)"
                }
            },
            j_bof_ballbo = {
                name = "Ballbo",
                text = {
                    'Gana {C:mult}+#1#{} Multi y aumenta',
                    'su {C:attention}escalado{} en {C:mult}+#2#{} Multi',
                    'si la mano jugada contiene',
                    "un {C:attention}Color{}",
                    "{C:inactive}(Actualmente {C:mult}+#3#{C:inactive} Multi)"
                }
            },
            j_bof_barber = {
                name = "Barbero",
                text = {
                    "Gana {C:money}$#1#{} al final de la ronda",
                    'Prob. de {C:green}#2# en #3#{} de',
                    'aumentar el pago en {C:money}$#4#',
                    "al seleccionar una {C:attention}Ciega{}"
                }
            },
            j_bof_eddrick = {
                name = "Mauricio el Malvado",
                text = {
                    "{C:chips}+#1#{} Fichas y {C:mult}+#2#{} Multi",
                    "en la {C:attention}mano final{} de la ronda"
                }
            },
            j_bof_handy_henry = {
                name = "Martín el Manitas",
                text = {
                    "{C:blue}+#1#{} mano por ronda",
                    "y {C:attention}#2#{} de tamaño de mano",
                    "por cada comodín a la",
                    "{C:attention}izquierda{}"
                }
            },
            j_bof_gary = {
                name = "Valerio el Viejito",
                text = {
                    "Gana {C:chips}+#1#{} Ficha#<s>1#",
                    "cuando se vende un comodín,",
                    "aumenta en {C:chips}+#2#{} Ficha#<s>2# al",
                    "derrotar una {C:attention}Ciega Jefe{}",
                    "{C:inactive}(Actualmente {C:chips}+#3#{C:inactive} Ficha#<s>3#)"
                }
            },
            j_bof_golden_sun = {
                name = "Mr. Golden Sun",
                text = {
                    "{C:white,X:mult}X#1#{} Multi",
                    "Destruye todas las cartas",
                    "en el {C:attention}descarte{} final",
                    "de {C:attention}póker{} cada ronda"
                }
            },
            j_bof_jim = {
                name = "Fabio el Flaco",
                text = {
                    "{C:blue}+#1#{} mano por ronda",
                    "{C:red}+#2#{} descarte cada ronda",
                    "{C:attention}#3#{} de tamaño de mano"
                }
            },
            j_bof_gumphrey = {
                name = "Gumphrey",
                text = {
                    "{C:mult}+#1#{} Multi por cada",
                    "carta {C:attention}Mejorada{} en",
                    "tu {C:attention}baraja{}",
                    "{C:inactive}(Actualmente {C:mult}+#2#{C:inactive} Multi)"
                }
            },
            j_bof_larry = {
                name = "Pelayo el Perezoso",
                text = {
                    "Gana {C:money}$#1#{} cuando",
                    "se juega la {C:attention}primera{} o",
                    "{C:attention}última mano{} de la ronda"
                }
            },
            j_bof_crafted = {
                name = "Comodín Artesanal",
                text = {
                    "Otorga {C:money}dinero{} igual al",
                    "número actual de {C:attention}rondas{}",
                    "completadas al omitir cualquier",
                    "{C:attention}Paquete Potenciador{}.",
                    "{C:red,E:2}Se autodestruye{}"
                }
            },
            j_bof_tom = {
                name = "Tomás Tumor",
                text = {
                    "{C:dark_edition}+#1#{} ranuras de comodín,",
                    "no puedes tener {C:attention}consumibles{}",
                }
            },
            j_bof_phony = {
                name = "Falso",
                text = {
                    "{C:mult}+#1#{} Multi",
                    "{C:chips}-#2#{} Fichas"
                }
            },
            j_bof_frank = {
                name = "Paolo Petimetre",
                text = {
                    "Crea una {C:attention}Etiqueta Doble{}",
                    "al omitir una {C:attention}Ciega{} si",
                    "no había {C:attention}Etiquetas{} previas"
                }
            },
            j_bof_super = {
                name = "Súper Comodín",
                text = {
                    "Si la {C:attention}Ciega{} no se gana",
                    "con la última mano, {C:blue}+#1#{} manos",
                    "{s:0.8}Solo puede activarse una vez por ronda"
                }
            },
            j_bof_eureka = {
                name = 'Emmanuel E. "Eureka"',
                text = {
                    {
                        "Los {C:tarot}Paquetes Arcanos{}",
                        "pueden contener cualquier",
                        "tipo de {C:attention}consumibles{}",
                    },
                    {
                        "Los {C:spectral}Paquetes Espectrales{}",
                        "y {C:planet}Paquetes Celestiales",
                        "pueden contener cartas {C:tarot}de Tarot{}"
                    }
                }
            },
            j_bof_timmy = {
                name = "Timoteo el Joven",
                text = {
                    "{C:blue}+#1#{} Ficha#<s>1# por cada",
                    "carta por encima de {C:attention}#2#",
                    "en tu baraja",
                    "{C:inactive}(Actualmente {C:blue}+#3#{C:inactive} Ficha#<s>3#)"
                },
            },
            j_bof_jack_frost = {
                name = "Emilio Frío",
                text = {
                    "{C:mult}+#1#{} Multi si la mano",
                    "de {C:attention}póker{} jugada no",
                    "se ha jugado antes",
                    "en esta ronda"
                }
            },
            j_bof_soothsayer = {
                name = "Adivino",
                text = {
                    {
                        "Crea una carta del {C:tarot}Tarot{}",
                        "si tienes un {C:tarot}Sello Morado{}",
                        "en mano al final de la ronda",
                    },
                    {
                        "Aumenta el nivel de la mano",
                        "de {C:attention}póker{} descartada si",
                        "contiene un {C:blue}Sello Azul{}",
                    },
                },
            },
            j_bof_polymath = {
                name = "Polímata",
                text = {
                    "Cada carta anotada y en mano",
                    'tiene una prob. de {C:green}#1# en #2#{} de otorgar',
                    "{C:mult}+#3#{} Multi, {C:chips}+#4#{} Ficha#<s>4#,",
                    "{X:mult,C:white}X#5#{} Multi y {C:money}$#6#"
                }
            },
            j_bof_manqian = {
                name = "Manqian",
                text = {
                    "Multiplica el {C:mult}Multi{} por",
                    "el {C:attention}nivel{} de la mano de póker",
                    "más jugada antes de anotar",
                    "{C:inactive}(Actualmente {C:attention}#1#{C:inactive} a {V:1}lvl.#2#{C:inactive})"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_narr = {
                name = "Narr",
                text = {
                    "Gana {C:white,X:mult}X#1#{} Multi por cada",
                    "{C:attention}carta{} del palo {V:1}#2#{} en",
                    "tu baraja al final de la ronda",
                    "{C:inactive}(Actualmente {C:white,X:mult}X#3#{C:inactive} Multi)"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_turold = {
                name = "Turold",
                text = {
                    'Gana {C:white,X:mult}X#1#{} Multi',
                    'cuando se juega una mano,',
                    "se {C:attention}reinicia{} al final de la ronda",
                    "{C:inactive}(Actualmente {C:white,X:mult}X#2#{C:inactive} Multi)"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_taillefer = {
                name = "Taillefer",
                text = {
                    "Llena las ranuras de consumibles",
                    "con cartas {C:spectral}Espectrales{} al azar",
                    "al seleccionar una {C:attention}Ciega{}"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_dagonet = {
                name = "Dagonet",
                text = {
                    "Las {C:attention}Cartas de Piedra{} anotadas otorgan",
                    "{C:mult}+#1#{} Multi, aumenta en {C:mult}+#2#{} Multi",
                    "cuando una {C:attention}Carta de Piedra{} se descarta"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_notebook = {
                name = "Cuaderno",
                text = {
                    {
                        "Otorga un {C:dark_edition}sticker{} a",
                        "un {C:attention}Comodín{} al azar",
                        "al seleccionar una {C:attention}Ciega{}"
                    },
                    {
                        "{C:red}Elimina{} dos {C:dark_edition}stickers{}",
                        "y ganas {C:money}$#1#{} cuando",
                        "se derrota una",
                        "{C:attention}Ciega Jefe{}"
                    }
                }
            },
            j_bof_eraser = {
                name = "Borrador",
                text = {
                    "Todas las cartas en mano dan",
                    "{C:mult}+#1#{} Multi pero {C:red}pierden{} cualquier",
                    "{C:attention}mejora{} que tengan"
                }
            },
            j_bof_rummikub = {
                name = "Ficha de Rummikub",
                text = {
                    "Gana {C:chips}+#1#{} Fichas si el",
                    "{C:attention}valor total{} de fichas de",
                    "las cartas jugadas es al menos {C:attention}#2#",
                    "{C:inactive}(Actualmente {C:chips}+#3#{C:inactive} Fichas)"
                }
            },
            j_bof_alarm_clock = {
                name = "Despertador",
                text = {
                    "{X:mult,C:white}X#1#{} Multi cada",
                    "{C:attention}2{} manos",
                    "{C:inactive}#2#{}",
                }
            },
            j_bof_passport = {
                name = "Pasaporte",
                text = {
                    {
                        "Gana {C:chips}+#1#{} Fichas por cada",
                        "{C:attention}Ciega única{} derrotada",
                        "{C:inactive}(Actualmente {C:chips}+#2#{C:inactive} Fichas)"
                    },
                    {
                        "Las {C:attention}Ciegas Jefe{} pueden",
                        "aparecer varias veces"
                    }
                }
            },
            j_bof_rogue = {
                name = "Pícaro",
                text = {
                    "Las cartas de {C:spades}Espada{}",
                    "o {C:clubs}Trébol{} dan",
                    "{C:money}$#1#{} al tenerlas en mano",
                    "al final de la ronda"
                }
            },
            j_bof_luminary = {
                name = "Luminaria",
                text = {
                    "Gana {C:money}$#1#{} al final de la ronda",
                    "Aumenta el pago en {C:money}$#2#{} por cada",
                    "mano jugada que contiene una carta",
                    "{C:attention}anotada{} y {C:attention}sin anotar{} con",
                    "{C:hearts}Corazón{} o {C:diamonds}Diamante{} esta ronda"
                }
            },
            j_bof_furious = {
                name = "Comodín Furioso",
                text = {
                    "Gana {C:money}$#1#{} al final",
                    "de la ronda",
                    "No ganas {C:money}intereses{}"
                }
            },
            j_bof_schlitzohr = {
                name = "Schlitzohr",
                text = {
                    "{C:red}Destruye{} una {C:attention}carta{} al",
                    "azar en la mano jugada",
                    "Este comodín no puede {C:red}destruir{}",
                    "cartas en la {C:attention}mano final{} de la ronda"
                }
            },
            j_bof_hotboxer = {
                name = "Hotboxer",
                text = {
                    "Si el último {C:red}descarte{} de",
                    "la ronda es una {C:attention}#1#{} sola",
                    "carta, agrega una {C:attention}copia{}",
                    "a la baraja o la {C:red}destruye{}"
                }
            }
        },
        Back = {
            b_bof_flannel = {
                name = "Baraja Flannel",
                text = {
                    "{C:mult}+#1#{} Multi"
                },
                unlock = {
                    "Lleva el {C:mult}Multi base{} de cualquier",
                    "mano de {C:attention}póker{} a al menos {C:attention}75{}"
                }
            },
            b_bof_illusion = {
                name = "Baraja de Ilusión",
                text = {
                    "Cuando se derrota una {C:attention}Ciega Jefe{}",
                    "aumenta las manos o descartes",
                    "en {C:plasma}+#1#{} para la siguiente {C:attention}Apuesta{}"
                },
                unlock = {
                    "Gana una partida con",
                    "{C:attention}#1#{} en {V:1}#2#{}",
                    "o {C:attention}#3#{} en {V:2}#4#{}"
                }
            },
            b_bof_wooden = {
                name = "Baraja de Madera",
                text = {
                    "Empiezas sin {C:attention}Ases{} y con un",
                    "grupo de {C:attention}2, {C:attention}3,",
                    "{C:attention}4{} y {C:attention}5{} adicionales"
                },
                unlock = {
                    "Destruye {C:attention}4 Ases{}",
                    "en una ronda"
                }
            },
            b_bof_soapy = {
                name = "Baraja Jabonosa",
                text = {
                    "Las cartas {C:attention}Mejoradas{} se",
                    "destruyen al {C:attention}descartarse{}"
                },
                unlock = {
                    "Destruye una carta con una",
                    "{C:enhanced}Mejora{}, {C:dark_edition}Edición{} y {C:attention}Sello{}"
                }
            },
            b_bof_display = {
                name = "Baraja Secuencial",
                text = {
                    "Empiezas con todos los {C:attention}rangos{} de un {C:attention}palo{}",
                    "Cuando se derrota una {C:attention}Ciega Jefe{},",
                    "añade una copia de cada {C:attention}rango",
                    "de un {C:attention}palo{} aleatorio al mazo"
                },
                unlock = {
                    "Ten solo una",
                    "{C:attention}Categoría{} en tu baraja"
                }
            },
            b_bof_retro = {
                name = "Baraja Retro",
                text = {
                    "Aumenta el nivel de",
                    "{C:attention}#1#{} manos de {C:attention}póker{} al azar",
                    "al omitir una {C:attention}Ciega{}"
                },
                unlock = {
                    "Juega todas las {C:attention}manos de póker",
                    "al menos una vez en una partida"
                }
            },
            b_bof_fossilized = {
                name = "Baraja Fosilizada",
                text = {
                    "Ganas {C:money}+$#1#{} adicionales al final de",
                    "la ronda por cada {C:attention}consumible{}",
                    "que tengas. Los {C:attention}consumibles{}",
                    "en la tienda pueden ser {C:dark_edition}Negativos{}"
                },
                unlock = {
                    "Ten un consumible cada tipo",
                    "en las ranuras de consumibles"
                }
            },
            b_bof_lightning = {
                name = "Baraja de Rayo",
                text = {
                    "{C:attention}Cartas{} de Figura empiezan",
                    "como {C:attention}Cartas de Multi{}",
                    "Las cartas jugadas no anotan",
                    "sus {C:chips}fichas base{}"
                },
                unlock = {
                    "Gana una partida sin usar",
                    "ninguna fuente de {C:mult}+Multi{},",
                    "{C:white,s:0.8,X:mult}XMulti{s:0.8} aún puede usarse"
                }
            }
        }
    },
    Fish = {
        j_bof_bass_s = {
            name = "Perca Americana {X:small}Pequeño",
            text = {
                "{C:chips}+#1#{} Fichas y",
                "{C:attention}+#2#{} ranura de consumibles",
                "mientras se posea",
                "{C:inactive}#3# rondas restantes..."
            }
        },
        j_bof_bass_b = {
            name = "Perca Americana {X:big}Grande",
            text = {
                "{C:chips}+#1#{} Fichas y",
                "{C:attention}+#2#{} ranura de consumibles",
                "mientras se posea",
                "{C:inactive}#3# rondas restantes..."
            }
        },
        j_bof_bass_l = {
            name = "Largemouth Bass {X:legendary}Legendaria",
            text = {
                "otorga {C:chips}+Fichas{} igual a",
                "el {C:attention}total{} de fichas que",
                "{C:attention}todas las cartas{} de tu baraja sumen,",
                "{C:attention}+#1#{} ranura de consumibles#<s>1# mientras se posea"
            }
        },
        j_bof_betta_s = {
            name = "Betta {X:small}Pequeño",
            text = {
                "{C:mult}+#1#{} Multi y",
                "{C:attention}+#2#{} ranura de consumibles#<s>2#",
                "mientras se posea",
                "{C:inactive}#3# rondas restantes..."
            }
        },
        j_bof_betta_b = {
            name = "Betta {X:big}Grande",
            text = {
                "{C:mult}+#1#{} Multi y",
                "{C:attention}+#2#{} ranura de consumibles#<s>2#",
                "mientras se posea",
                "{C:inactive}#3# rondas restantes..."
            }
        },
        j_bof_betta_l = {
            name = "Betta {X:legendary}Legendario",
            text = {
                "Otorga {C:mult}+Multi{} igual al",
                "Multi {C:attention}total{} de todas",
                "las {C:attention}manos de poker{} juntas,",
                "{C:attention}+#1#{} ranura de consumibles#<s>1# mientras se posea"
            }
        },
        j_bof_trout_s = {
            name = "Trucha Arcoiris {X:small}Pequeña",
            text = {
                "{C:white,X:mult}X#1#{} Multi y",
                "{C:attention}+#2#{} ranura de consumibles#<s>2#",
                "mientras se posea",
                "{C:inactive}#3# rondas restantes..."
            }
        },
        j_bof_trout_b = {
            name = "Trucha Arcoiris {X:big}Grande",
            text = {
                "{C:white,X:mult}X#1#{} Multi y",
                "{C:attention}+#2#{} ranura de consumibles#<s>2#",
                "mientras se posea",
                "{C:inactive}#3# rondas restantes..."
            }
        },
        j_bof_trout_l = {
            name = "Trucha Arcoiris {X:legendary}Legendaria",
            text = {
                "Los Comodines y otros consumibles",
                "otorgan {C:white,X:mult}X#1#{} Multi,",
                "{C:attention}+#2#{} ranura de consumibles mientras se posea"
            }
        },
        j_bof_goldfish_s = {
            name = "Pez Dorado {X:small}Pequeño",
            text = {
                "Ganas {C:money}$#1#{} y",
                "{C:attention}+#2#{} ranura de consumibles#<s>2#",
                "mientras se posea",
                "{C:inactive}#3# rondas restantes..."
            }
        },
        j_bof_goldfish_b = {
            name = "Pez Dorado {X:big}Grande",
            text = {
                "Earn {C:money}$#1#{} and",
                "{C:attention}+#2#{} consumable slot#<s>2# while held",
                "{C:inactive}#3# rounds remaining..."
            }
        },
        j_bof_goldfish_l = {
            name = "Pez Dorado {X:legendary}Legendario",
            text = {
                "Ganas dinero igual al",
                "{C:money}interés{} total {C:attention}acumulado{}",
                "que se habría ganado,",
                "{C:attention}+#1#{} ranura de consumibles#<s>1# mientras se posea"
            }
        }
    },
    Other = {
        p_bof_tackle_normal = {
            name = "Paquete Pescador",
            text = {
                "Escoge {C:attention}#1#{} de hasta",
                "{C:attention}#2# {C:fish}Peces{}"
            }
        },
        p_bof_tackle_jumbo = {
            name = "Paquete Pescador Jumbo",
            text = {
                "Escoge {C:attention}#1#{} de hasta",
                "{C:attention}#2# {C:fish}Peces{}"
            }
        },
        p_bof_fry = {
            name = "Paquete Frito",
            text = {
                "Escoge {C:attention}#1#{} de hasta",
                "{C:attention}#2# {C:white,X:small}Peces Pequeños{}"
            }
        },
        p_bof_hooked = {
            name = "Paquete de Cebo",
            text = {
                "Escoge {C:attention}#1#{} de hasta",
                "{C:attention}#2# {C:white,X:big}Peces Grandes{}"
            }
        }
    },
    misc = {
        dictionary = {
            k_bof_active = "¡Activo!",
            k_bof_ready = "¡Listo!",
            k_bof_destroyed = "¡Destruido!",
            b_fish_cards = "Cartas de Pescador",
            k_bof_alarm = "¡Alarma lista!",
            k_bof_downgrade = "¡Desgaste!",
            k_bof_sticker_applied = "¡Sticker Aplicado!",
            k_bof_tackle = "Paquete Pescador",
            k_bof_fry = "Paquete Frito",
            k_bof_hooked = "Paquete de Cebo",
            k_fish = "Pez",

            option_bof_appetizers = "Appetizers",
            option_bof_jesters = "Jesters",
            option_bof_normalities = "Normalities",
            option_bof_fables = "Fables",
            option_bof_flats = "Flats",
            option_bof_fish = "Fish",
            -- option_bof_enemies = "Enemies",
            -- option_bof_finishers = "Finishers",
            -- option_bof_coupons = "Coupons"
        }
    }
}
