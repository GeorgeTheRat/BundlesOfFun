return {
    descriptions = {
        Joker = {
            -- Appetizers
            j_bof_dragonfruit = {
                name = "Pitahaya",
                text = {
                    "Añade una copia permanente",
                    "de todas las cartas {C:attention}jugadas{}",
                    "a la siguiente mano,",
                    "{C:red,E:2}se autodestruye{}"
                }
            },
            j_bof_blueberries = {
                name = "Arándanos",
                text = {
                    "Cada {C:attention}carta{} en la mano",
                    "gana {C:chips}+#1#{} Ficha#<s>1# permanente,",
                    "se reduce en {C:chips}-#2#{} Ficha#<s>2#",
                    "al final de la ronda"
                }
            },
            j_bof_grapes = {
                name = "Uvas",
                text = {
                    "{C:chips}+#1#{} Ficha#<s>1#, {C:mult}+#2#{} Multi, {C:white,X:mult}X#3#{} Multi",
                    "se destruye al derrotar una {C:attention}Ciega Jefe{}"
                }
            },
            j_bof_leek = {
                name = "Puerro",
                text = {
                    "Aumenta todas las",
                    "{C:green,E:1}probabilidades{} en {C:green}+#1#{},",
                    "disminuye en {C:red}-#2#{} cuando",
                    "una {C:green}probabilidad{} tiene éxito"
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
            j_bof_bread = {
                name = "Pan Maravilloso",
                text = {
                    "Balancea un {C:white,X:plasma}#1#%{} de {C:chips}Fichas{}",
                    "y {C:mult}Multi{}, disminuye en {C:white,X:plasma}-#2#%{}",
                    "al final de la ronda"
                }
            },
            j_bof_candy = {
                name = "Dulce de Bolsillo",
                text = {
                    "Al omitir la siguiente {C:attention}#1# Ciega#<s>1#{},",
                    "crea una {C:attention}Etiqueta de Malabar{}"
                }
            },
            j_bof_apple = {
                name = "Manzana",
                text = {
                    "Cada carta anotada",
                    "gana {C:mult}+#1#{} Multi permanente,",
                    "se reduce en {C:mult}-#2#{} Multi",
                    "al final de la ronda",
                }
            },
            j_bof_core = {
                name = "Corazón de manzana",
                text = {
                    "Las siguientes {C:attention}#1#{}",
                    "cartas jugadas otorgan {C:mult}+#2#{} Multi",
                    "en lugar de anotar"
                }
            },
            j_bof_tomatoes = {
                name = "Tomates",
                text = {
                    "Las siguientes {C:attention}#1#{} cartas",
                    "en la mano tienen una prob. de",
                    "{C:green}#2# en #3#{} de volverse cartas",
                    "{C:attention}Multi{} o {C:attention}de la Suerte{}"
                }
            },
            j_bof_shrimp = {
                name = "Camarón frito",
                text = {
                    "Los próximos {C:attention}#1# Paquete#<s>1# Potenciador#<es>1#",
                    "contienen#<n>1# una carta {C:fish}Pez{} {C:white,X:small}Pequeño{}",
                    "y una {C:white,X:big}Grande{} adicional#<es>1#{}"
                }
            },
            -- Jesters
            j_bof_hal = {
                name = "Sergio Sombredero",
                text = {
                    "Gana {C:chips}+#1#{} Ficha#<s>1#",
                    "y aumenta su {C:attention}escalado{} en",
                    "{C:chips}+#2#{} Ficha#<s>2# cada vez que se añade una",
                    "{C:attention}Carta de juego{} a tu baraja",
                    "{C:inactive}(Actualmente {C:chips}+#3#{C:inactive} Ficha#<s>3#)"
                }
            },
            j_bof_henry = {
                name = "Martín el Manitas",
                text = {
                    "Ganas {C:money}$#1#{} adicional",
                    "por {C:blue}Mano{} {C:attention}restante{}",
                    "al final de cada ronda"
                }
            },
            j_bof_tom = {
                name = "Tomás Tumor",
                text = {
                    "{C:dark_edition}+#1#{} ranura#<s>1# de comodín,",
                    "{C:red}-#2#{} ranura#<s>2# de consumible"
                }
            },
            j_bof_barber = {
                name = "Barbero",
                text = {
                    "Al seleccionar una {C:attention}Ciega{},",
                    "gana {C:mult}+#1#{} Multi y remueve una",
                    "{C:attention}Mejora{} de {C:attention}#2#{} carta#<s>2#",
                    "al azar de tu baraja",
                    "{C:inactive}(Actualmente {C:mult}+#3#{C:inactive} Multi)"
                }
            },
            j_bof_ballbo = {
                name = "Ballbo",
                text = {
                    "Obtiene {C:mult}+#1#{} Multi y aumenta su",
                    "{C:attention}escalado{} en {C:mult}+#2#{} Multi si la",
                    "mano jugada contiene un {C:attention}Color{}",
                    "{C:inactive}(Actualmente {C:mult}+#3#{C:inactive} Multi)"
                }
            },
            j_bof_rogue = {
                name = "Pícaro",
                text = {
                    "Las cartas con palo {C:spades}Espadas{} o {C:clubs}Tréboles{}",
                    "otorgan {C:money}$#1#{} si están",
                    "en mano al final de la ronda",
                }
            },
            j_bof_eddrick = {
                name = "Mauricio el Malvado",
                text = {
                    "{C:chips}+#1#{} Fichas y {C:mult}+#2#{} Multi",
                    "en la {C:attention}mano final{} de la ronda"
                }
            },
            j_bof_super = {
                name = "Súper Comodín",
                text = {
                    "{C:blue}+#1#{} mano#<s>1# si la {C:attention}Ciega{} no se",
                    "gana con la {C:attention}mano final{}",
                    "{C:inactive,s:0.8}(Solo puede activarse una vez por ronda)"
                }
            },
            j_bof_eureka = {
                name = "Emmanuel E. \"Eureka\"",
                text = {
                    {
                        "Los {C:tarot}Paquetes Arcanos{} pueden",
                        "contener {C:attention}consumibles{} de",
                        "todos los tipos"
                    },
                    {
                        "Los {C:spectral}Paquetes Espectrales{}",
                        "y {C:planet}Paquetes Celestiales{} pueden",
                        "contener cartas del {C:tarot}Tarot{}"
                    },
                    {
                        "Los {C:fish}Paquetes de Pescador{}",
                        "siempre contienen {C:fish}Peces{} {C:white,E:1,X:big}Grandes{}"
                    },
                    -- {
                    --     "Las cartas {C:attention}sin mejoras{} en",
                    --     "los {C:attention}Paquetes Estándar{} se vuelven {C:enhanced}Madera{}"
                    -- }
                }
            },
            j_bof_matey = {
                name = "Camarada",
                text = {
                    "Las cartas de {C:fish}Pez{} {C:white,E:1,X:big}Grandes{}",
                    "se transforman en su",
                    "carta de {C:fish}Pez{} {C:white,E:1,X:small}Pequeña{}",
                    "en lugar de expirar",
                    "siempre contienen solo",
                    "{C:white,X:big}Grandes{} {C:fish}Peces{}"
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
            j_bof_gary = {
                name = "Valerio el Viejito",
                text = {
                    "Obtiene {C:chips}+Fichas{} iguales a",
                    "la {C:attention}Apuesta{} actual cuando",
                    "se vende un comodín",
                    "{C:inactive}(Actualmente {C:chips}+#1#{C:inactive} Ficha#<s>1#)"
                }
            },
            j_bof_golden_sun = {
                name = "Mr. Golden Sun",
                text = {
                    {
                        "{C:red}Destruye{} todas las cartas en el",
                        "último {C:attention}descarte{} de cada ronda"
                    },
                    {
                        "Reduce a la mitad las {C:chips}Fichas{}",
                        "y el {C:mult}Multi{} al calcular la",
                        "puntuación de la mano jugada"
                    }
                }
            },
            j_bof_jack_frost = {
                name = "Emilio Frío",
                text = {
                    "{C:mult}+#1#{} Multi si la mano",
                    "{C:attention}de póker{} jugada no ha sido",
                    "jugada anteriormente",
                    "en esta ronda"
                }
            },
            j_bof_jim = {
                name = "Fabio el Flaco",
                text = {
                    "{C:blue}+#1#{} mano por ronda",
                    "{C:red}+#2#{} descarte por ronda",
                    "{C:attention}#3#{} de tamaño de mano"
                }
            },
            j_bof_gumphrey = {
                name = "Gumphrey",
                text = {
                    "{C:mult}+#1#{} Multi por cada carta",
                    "{C:attention}Mejorada{} en tu {C:attention}baraja{}",
                    "{C:inactive}(Actualmente {C:mult}+#2#{C:inactive} Multi)"
                }
            },
            j_bof_soothsayer = {
                name = "Adivino",
                text = {
                    "Crea la carta {C:planet}Planeta{} para la",
                    "{C:attention}mano de póker{} descartada si",
                    "contiene una carta con {C:blue}Sello Azul{}",
                    "{C:inactive}(Debe haber espacio)"
                },
            },
            j_bof_polymath = {
                name = "Polímata",
                text = {
                    "Cada carta anotada y cada carta en mano",
                    "tiene una prob. de {C:green}#1# en #2#{} de otorgar",
                    "{C:chips}+#3#{} Ficha#<s>3#, {C:mult}+#4#{} Multi, {C:white,X:mult}X#5#{} Multi y {C:money}$#6#"
                }
            },
            j_bof_luminary = {
                name = "Luminaria",
                text = {
                    "Ganas {C:money}$#1#{} al final de la ronda",
                    "Aumenta en {C:money}$#2#{} por cada mano",
                    "jugada que contiene una carta",
                    "{C:attention}jugada{} y {C:attention}sin anotar{} con palo",
                    "{C:hearts}Corazón{} o {C:diamonds}Diamante{}"
                }
            },
            j_bof_furious = {
                name = "Comodín Furioso",
                text = {
                    "Gana {C:money}$#1#{} al",
                    "final de la ronda",
                    "No ganas {C:attention}interés{}"
                }
            },
            j_bof_larry = {
                name = "Pelayo el Perezoso",
                text = {
                    "Ganas {C:money}$#1#{} cuando se juega la",
                    "{C:attention}primera{} o la {C:attention}última mano{}",
                    "de la ronda"
                }
            },
            j_bof_phony = {
                name = "Falso",
                text = {
                    "{C:mult}+#1#{} Multi",
                    "{C:chips}-#2#{} Fichas"
                }
            },
            j_bof_fancy = {
                name = "Pantalones Elegantes",
                text = {
                    "Crea una {C:attention}Etiqueta Manual{} o",
                    "una {C:attention}Etiqueta de Basura{} al azar",
                    "al seleccionar una {C:small,E:1}Ciega Pequeña{}"
                }
            },
            j_bof_crafted = {
                name = "Comodín Artesanal",
                text = {
                    "Al jugar la {C:attention}primera{} mano de la ronda",
                    "copia todas las {C:attention}modificaciones{} de la",
                    "carta del {C:attention}extremo izquierdo{} a la carta",
                    "del {C:attention}extremo derecho{} en la mano jugada,",
                    "luego {C:red}destruye{} la carta del extremo izquierdo"
                }
            },
            j_bof_schlitzohr = {
                name = "Schlitzohr",
                text = {
                    "Cambia la {C:attention}categoría{} de las {C:attention}#1#{}",
                    "cartas de menor categoría en tu",
                    "baraja al seleccionar una {C:attention}Ciega{}"
                }
            },
            j_bof_hotboxer = {
                name = "Hotboxer",
                text = {
                    {
                        "{C:attention}+#1#{} ranura#<s>1# de tienda, la ranura",
                        "de la tienda del {C:attention}extremo derecho{}",
                        "contiene solo cartas del {C:tarot}Tarot{}"
                    },
                    {
                        "Pierde {C:money}$#2#{} de {C:attention}valor",
                        "{C:attention}venta{} por cada carta del",
                        "{C:tarot}Tarot{} comprada"
                    }
                }
            },
            j_bof_director = {
                name = "Director",
                text = {
                    "{C:white,X:mult}X#1#{} Multi, se reactiva",
                    "{C:attention}una vez{} por cada carta",
                    "jugada que se haya {C:attention}reactivado{}"
                }
            },
            j_bof_zeke = {
                name = "Zipper Zeke",
                text = {
                    "Prob. de {C:green}#1# en #2#{} de crear",
                    "un comodín que no {C:common}Común{} cuando",
                    "se {C:attention}vende{} una carta del {C:tarot}Tarot{}",
                    "{C:inactive}(Debe haber espacio)"
                }
            },
            j_bof_laughing_stock = {
                name = "Hazmerreír",
                text = {
                    "{C:red}Destruye{} cada carta jugada con",
                    "una {C:attention}#1#{} y disminuye",
                    "la puntuación requerida del",
                    "{C:attention}tipo de    Ciega actual{} en {C:attention}#2#%{} por carta,",
                    "{C:attention,s:0.8}La Mejora{s:0.8} cambia cada ronda"
                }
            },
            j_bof_angler = {
                name = "Pescador",
                text = {
                    {
                        "{C:chips}+#1#{} Ficha#<s>2# por cada",
                        "carta {C:fish}Pez{} en mano",
                        "{C:inactive}(Actualmente {C:chips}+#2#{C:inactive} Ficha#<s>2#)",
                    },
                    {
                        "{C:mult}+#3#{} Multi por cada",
                        "carta {C:fish}Pez{} caducada",
                        "{C:inactive}(Actualmente {C:mult}+#4#{C:inactive} Multi)",
                    }
                }
            },
            j_bof_pianoman = {
                name = "Pianista",
                text = {
                    "Solo aparecen comodines {C:common}Comunes{}",
                    "en la tienda, puedes seleccionar cartas",
                    "{C:attention}ilimitadas{} de los {C:attention}Paquetes Potenciadores{}"
                }
            },
            j_bof_bouncer = {
                name = "Portero",
                text = {
                    "{C:mult}+#1#{} Multi si tienes",
                    "al menos {C:attention}#2#{} carta#<s>2# con el",
                    "mismo {C:attention}palo{} en tu {C:attention}baraja{}"
                }
            },
            j_bof_elephant = {
                name = "Elefante",
                text = {
                    "{C:chips}+#1#{} Fichas si todas",
                    "las cartas {C:attention}jugadas{} son",
                    "de la misma {C:attention}categoría{}"
                }
            },
            j_bof_prom_king = {
                name = "Rey del Baile",
                text = {
                    "Los {C:attention}Reyes{} jugados otorgan",
                    "{X:mult,C:white}X#1#{} Multi adicional al",
                    "anotar por cada {C:attention}Reina{}",
                    "jugada o en mano"
                }
            },
            j_bof_prom_queen = {
                name = "Reina del Baile",
                text = {
                    "Cada {C:attention}Reina{} en mano otorga",
                    "{C:chips}+#1#{} Fichas por cada {C:attention}Rey{}",
                    "jugado o en mano"
                }
            },
            j_bof_freeze = {
                name = "Cerebro Congelado",
                text = {
                    "Este comodín baja el {C:attention}nivel{} de una",
                    "{C:attention}mano de póker{} al azar",
                    "y gana {C:white,X:mult}X#1#{} Multi cada",
                    "carta {C:planet}Planeta{} vendida",
                    "{C:inactive,s:0.8}#2#",
                    "{C:inactive}(Actualmente {C:white,X:mult}X#3#{C:inactive} Multi)"
                }
            },
            j_bof_satanist = {
                name = "Satanista",
                text = {
                    "Reactiva cada {C:attention}otra{} carta",
                    "jugada {C:attention}una vez{} por cada",
                    "{C:attention}6{} en la mano jugada"
                }
            },
            j_bof_printed = {
                name = "Comodín Impreso en 3D",
                text = {
                    "Copia las habilidades de todos",
                    "los {C:common}Comodines {C:attention}Comunes{} en mano"
                }
            },
            -- Normalities
            j_bof_fnesen = {
                name = "Fnesen",
                text = {
                    {
                        "Debilita un {C:attention}Comodín{}",
                        "al azar cada mano jugada"
                    },
                    {
                        "Si este Comodín está debilitado,",
                        "en su lugar da {C:white,X:mult}X#1#{} Multi"
                    }
                }
            },
            j_bof_jocker = {
                name = "Jocker",
                text = {
                    {
                        "Gana {C:money}$#1#{} cuando se",
                        "compra un {C:attention}Comodín{}",
                        "{C:common}Común{} o {C:uncommon}Inusual{}"
                    },
                    {
                        "Los {C:attention}Comodines{} {C:rare}Raros{}",
                        "cuestan {C:attention}el doble{}"
                    }
                }
            },
            j_bof_nerd = {
                name = "Nerd",
                text = {
                    "Cada {C:attention}#1#{} renovaciones en",
                    "la tienda {C:green,E:1}garantiza{}",
                    "un {C:attention}Comodín{} {C:rare}Raro{}"
                }
            },
            j_bof_postman = {
                name = "Cartero",
                text = {
                    "Las primeras {C:attention}cuatro{} cartas",
                    "jugadas también cuentan",
                    "como {C:spades}Espadas{}, {C:hearts}Corazones{},",
                    "{C:clubs}Tréboles{} o {C:diamonds}Diamantes{}",
                    "respectivamente"
                }
            },
            j_bof_notebook = {
                name = "Cuaderno",
                text = {
                    {
                        "Aplica un {C:dark_edition}sticker{} a",
                        "un comodín al azar al",
                        "seleccionar una {C:attention}Ciega{}"
                    },
                    {
                        "Elimina dos {C:dark_edition}stickers{}",
                        "y gana {C:money}$#1#{} cuando se",
                        "derrota la {C:attention}Ciega Jefe{}"
                    }
                }
            },
            j_bof_eraser = {
                name = "Borrador",
                text = {
                    "Todas las cartas en mano",
                    "otorgan {C:mult}+#1#{} Multi pero",
                    "{C:red}pierden{} sus {C:attention}modificaciones{}"
                }
            },
            j_bof_rummikub = {
                name = "Ficha de Rummikub",
                text = {
                    "Obtiene {C:chips}+#1#{} Ficha#<s>1# si el",
                    "{C:attention}total{} de fichas de las cartas",
                    "jugadas es al menos {C:attention}#2#",
                    "{C:inactive}(Actualmente {C:chips}+#3#{C:inactive} Ficha#<s>3#)"
                }
            },
            j_bof_passport = {
                name = "Pasaporte",
                text = {
                    {
                        "Obtiene {C:chips}+#1#{} Ficha#<s>1# por cada",
                        "{C:attention}Ciega única{} derrotada",
                        "{C:inactive}(Actualmente {C:chips}+#2#{C:inactive} Ficha#<s>2#)"
                    },
                    {
                        "Las {C:attention}Ciegas Jefe{} pueden",
                        "aparecer varias veces"
                    }
                }
            },
            j_bof_clock_inactive = {
                name = "Despertador",
                text = {
                    "{X:mult,C:white}X#1#{} Multi cada",
                    "{C:attention}par{} de manos",
                    "{C:inactive}Inactivo...",
                }
            },
            j_bof_clock_active = {
                name = "Despertador",
                text = {
                    "{X:mult,C:white}X#1#{} Multi cada",
                    "{C:attention}par{} de manos",
                    "{C:inactive,E:bof_alarm}¡Activo!",
                }
            },
            j_bof_keyboard = {
                name = "Teclado",
                text = {
                    "Las {C:attention}8{} jugados otorgan {C:mult}+#1#{} Multi",
                    "por cada {C:attention}8{} en tu baraja",
                    "al anotar",
                    "{C:inactive}(Actualmente {C:mult}+#2#{C:inactive} Multi)"
                }
            },
            j_bof_gnome = {
                name = "Gnomo de jardín",
                text = {
                    "Las cartas con {C:dark_edition}Edición{}",
                    "en la tienda son {C:attention}gratis{}"
                }
            },
            j_bof_astrolabe = {
                name = "Astrolabio",
                text = {
                    "Al usar una carta {C:planet}Planeta{} de un",
                    "{C:planet}Paquete Celestial{}, crea una",
                    "carta {C:planet}Planeta{} al azar"
                }
            },
            -- Fables
            j_bof_narr = {
                name = "Narr",
                text = {
                    "Gana {C:white,X:mult}X#1#{} Multi por cada",
                    "{C:attention}carta{} de palo {V:1}#2#{} en tu",
                    "baraja al final de la ronda",
                    "{C:inactive}(Actualmente {C:white,X:mult}X#3#{C:inactive} Multi)"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_manqian = {
                name = "Manqian",
                text = {
                    "{C:white,X:mult}Multiplica{C:mult} el Multi{} por",
                    "el {C:attention}nivel{} de la mano de póker",
                    "{C:attention}más jugada{} antes de anotar",
                    "{C:inactive}(Actualmente {C:attention}#1#{C:inactive} a {C:inactive}{V:1}lvl.#2#{C:inactive})"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_turold = {
                name = "Turold",
                text = {
                    "Obtiene {C:white,X:mult}X#1#{} Multi cuando",
                    "se juega una mano, se",
                    "{C:attention}reinicia{} al final de la ronda",
                    "{C:inactive}(Actualmente {C:white,X:mult}X#2#{C:inactive} Multi)"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_taillefer = {
                name = "Taillefer",
                text = {
                    "Llena las ranuras de {C:attention}consumibles{}",
                    "con cartas {C:spectral}Espectrales{} al azar",
                    "al seleccionar una {C:attention}Ciega{},",
                    "{C:attention}+#1#{} ranura de consumibles"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_glue = {
                name = "Glue",
                text = {
                    "Las {C:attention}cartas Mejoradas{} jugadas",
                    "otorgan {C:mult}+#1#{} Multi al anotar, aumenta",
                    "en {C:mult}+#2#{} Multi cuando se",
                    "descarta una {C:attention}carta Mejorada{}"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_gonella = {
                name = "Gonella",
                text = {
                    {
                        "La carta del {C:attention}fondo{} de la baraja se",
                        "convierte en una {C:attention}Carta de la Suerte{}",
                        "al seleccionar una {C:attention}Ciega{}",
                    },
                    {
                        "Todas las {C:green,E:1}probabilidades{} están",
                        "{C:green}garantizadas{} durante la",
                        "{C:attention}Ciega Jefe{}",
                    }
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_durie = {
                name = "Durie",
                text = {
                    {
                        "Al {C:white,X:red}Descartar{}, otorga",
                        "{C:dark_edition}Negativa{} a",
                        "las cartas seleccionadas",
                    },
                    {
                        "Las cartas de juego {C:dark_edition}Negativas{}",
                        "pierden su {C:dark_edition}Edición{}",
                        "al final de la ronda"
                    }
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_mezzetino = {
                name = "Mezzetino",
                text = {
                    "Crea una carta de {C:planet}Planeta{}",
                    "{C:dark_edition}Negativa{} de la",
                    "la mano jugada",
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_beltrame = {
                name = "Beltrame",
                text = {
                    {
                        "Las cartas en mano al final de la ronda",
                        "crean {C:attention}Etiquetas{} según su {C:attention}palo{}",
                        "{C:inactive,s:0.8}(No puede crear más de {C:attention,s:0.8}#1#{C:inactive,s:0.8} Etiqueta#<s>1# a la vez)"
                    },
                    {
                        "{C:spades,s:0.9}Espadas{s:0.9}: Etiquetas {C:dark_edition,s:0.9}Polícromas{}",
                        "{C:hearts,s:0.9}Corazones{s:0.9}: Etiquetas de {C:red,s:0.9}Basura{}",
                        "{C:clubs,s:0.9}Tréboles{s:0.9}: Etiquetas {C:planet,s:0.9}Orbitales{}",
                        "{C:diamonds,s:0.9}Diamantes{s:0.9}: Etiquetas {C:attention,s:0.9}Estándar{}"
                    }
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            j_bof_nuwa_fuxi = {
                name = "Nüwa y Fuxi",
                text = {
                    {
                        "Crea una carta del {C:tarot}Tarot{} al seleccionar",
                        "una {C:attention}Ciega{} y una carta {C:dark_edition}Negativa{}",
                        "del {C:tarot}Tarot{} al derrotar una {C:attention}Ciega{}",
                        "si está en el {C:attention}extremo izquierdo{}",
                        "{C:inactive}(Debe haber espacio)"
                    },
                    {
                        "Crea una carta {C:fish}Pez{} {C:white,X:small}Pequeña{} al seleccionar",
                        "una {C:attention}Ciega{} y una {C:white,X:big}Grande{}",
                        "al derrotar una {C:attention}Ciega{} si está en el",
                        "{C:attention}extremo derecho{}",
                        "{C:inactive}(Debe haber espacio)"
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
                name = "Baraja Bordada",
                text = {
                    "Empiezas con una {C:attention}categoría{}",
                    "al azar ausente de la baraja",
                    "Al derrotar una {C:attention}Ciega Jefe{},",
                    "añade {C:attention}4{} cartas a la baraja de cada",
                    "{C:attention}palo{} de una {C:attention}categoría{} al azar",
                    "{C:inactive,s:0.8}(ej.: {C:attention,s:0.8}K de Espadas{C:inactive,s:0.8}, {C:attention,s:0.8}Corazones{C:inactive,s:0.8}, {C:attention,s:0.8}Tréboles{C:inactive,s:0.8} y {C:attention,s:0.8}Diamantes{C:inactive,s:0.8})"
                },
                unlock = {
                    "Ten {C:attention}80{} o más",
                    "cartas en tu baraja"
                }
            },
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
                    "Cuando se derrota una {C:attention}Ciega Jefe{},",
                    "aumenta las manos o descartes",
                    "en {C:plasma}+#1#{} para la siguiente {C:attention}Apuesta{}"
                },
                unlock = {
                    "Gana una partida con",
                    "{C:attention}#1#{} en {V:1}#2#{}",
                    "o {C:attention}#3#{} en {V:2}#4#{}"
                }
            },
            b_bof_fossilized = {
                name = "Baraja Fosilizada",
                text = {
                    "Ganas {C:money}+$#1#{} adicionales al final de",
                    "la ronda por cada {C:attention}consumible{} en mano",
                    "Los {C:attention}consumibles{} en la tienda",
                    "pueden ser raramente {C:dark_edition,T:e_negative}Negativos{}"
                },
                unlock = {
                    "Ten un consumible de cada tipo",
                    "en las ranuras de consumibles"
                }
            },
            b_bof_wooden = {
                name = "Baraja de Madera",
                text = {
                    "Empiezas sin {C:attention}Ases{} y con un",
                    "grupo de {C:attention}2s{}, {C:attention}3s{},",
                    "{C:attention}4s{} y {C:attention}5s{} adicionales",
                    "Todas las cartas empiezan {C:attention,T:m_bof_wooden}de Madera"
                },
                unlock = {
                    "Destruye {C:attention}4 Ases{}",
                    "en una ronda"
                }
            },
            b_bof_backgammon = {
                name = "Baraja Backgammon",
                text = {
                    "Convierte cada carta anotada con",
                    "palo {C:spades}Espadas{} o {C:clubs}Tréboles{} a {C:hearts}Corazones{}",
                    "o {C:diamonds}Diamantes{} y viceversa",
                    "No tiene efecto si las ranuras de comodín están llenas"
                },
                unlock = {
                    "Ten solo un",
                    "{C:attention}palo{} en tu baraja"
                }
            },
            b_bof_scaly = {
                name = "Baraja Escamosa",
                text = {
                    "Empiezas con {C:attention,T:v_bof_ice_bucket}Cubo de Hielo{} y",
                    "{C:attention}2{} copias de {C:fish,T:c_bof_octopus_b}Pulpo {C:white,E:1,X:big}Grande"
                },
                unlock = {
                    "Descubre una",
                    "carta de {C:fish}Pez{} {C:white,E:1,X:legendary}Legendaria{}"
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
                    "Juega todas las {C:attention}manos de póker{}",
                    "al menos una vez en una partida"
                }
            },
            b_bof_soapy = {
                name = "Baraja Jabonosa",
                text = {
                    "Las cartas {C:attention}Mejoradas{} se",
                    "{C:red}destruyen{} al {C:attention}descartarse{}"
                },
                unlock = {
                    "Destruye una carta con una",
                    "{C:enhanced}Mejora{}, {C:dark_edition}Edición{} y {C:attention}Sello{}"
                }
            },
            b_bof_display = {
                name = "Baraja de Muestra",
                text = {
                    "Previsualiza la próxima {C:attention}Ciega Desafiante{}",
                    "y la próxima {C:attention}Ciega Jefe{} en cualquier momento",
                    "{C:inactive}(Ver Info de Partida)"
                },
                unlock = {
                    "Renueva una {C:attention}Ciega Desafiante{}"
                }
            },
            b_bof_lightning = {
                name = "Baraja de Rayo",
                text = {
                    "Las {C:attention}Cartas de Figura{} empiezan",
                    "como {C:attention}Cartas de Multi{}",
                    "Las cartas jugadas no dan",
                    "sus {C:chips}fichas base{} al anotar"
                },
                unlock = {
                    "Gana una partida sin usar",
                    "ninguna fuente de {C:mult}+Multi{},",
                    "{C:white,s:0.8,X:mult}XMulti{s:0.8} aún puede usarse"
                }
            }
        },
        -- wooden (for, what do you know, wooden deck)
        Enhanced = {
            m_bof_wooden = {
                name = "Madera",
                text = {
                    "{C:chips}+#1#{} fichas extra",
                    "{s:0.8}no cuenta para",
                    "{C:attention,s:0.8}efectos de mejora{}"
                }
            }
        },
        -- fish
        Fish = {
            c_bof_bass_s = {
                name = "Perca Americana {X:small}Pequeña",
                text = {
                    "{C:chips}+#1#{} Fichas",
                    "{C:inactive}#3# ronda#<s>3# restante#<s>3#...",
                    "{C:attention,s:0.8}+#2#{} {C:inactive,s:0.8}ranura#<s>2# de consumible mientras se posea{}",
                }
            },
            c_bof_betta_s = {
                name = "Betta {X:small}Pequeño",
                text = {
                    "{C:mult}+#1#{} Multi",
                    "{C:inactive}#3# ronda#<s>3# restante#<s>3#...",
                    "{C:attention,s:0.8}+#2#{} {C:inactive,s:0.8}ranura#<s>2# de consumible mientras se posea{}",
                }
            },
            c_bof_trout_s = {
                name = "Trucha Arcoíris {X:small}Pequeña",
                text = {
                    "{C:white,X:mult}X#1#{} Multi",
                    "{C:inactive}#3# ronda#<s>3# restante#<s>3#...",
                    "{C:attention,s:0.8}+#2#{} {C:inactive,s:0.8}ranura#<s>2# de consumible mientras se posea{}",
                }
            },
            c_bof_goldfish_s = {
                name = "Pez Dorado {X:small}Pequeño",
                text = {
                    "Gana {C:money}$#1#{}",
                    "{C:inactive}#3# ronda#<s>3# restante#<s>3#...",
                    "{C:attention,s:0.8}+#2#{} {C:inactive,s:0.8}ranura#<s>2# de consumible mientras se posea{}",
                }
            },
            c_bof_bass_b = {
                name = "Perca Americana {X:big}Grande",
                text = {
                    "{C:chips}+#1#{} Fichas",
                    "{C:inactive}#3# ronda#<s>3# restante#<s>3#...",
                    "{C:attention,s:0.8}+#2#{} {C:inactive,s:0.8}ranura#<s>2# de consumible mientras se posea{}",
                }
            },
            c_bof_betta_b = {
                name = "Betta {X:big}Grande",
                text = {
                    "{C:mult}+#1#{} Multi",
                    "{C:inactive}#3# ronda#<s>3# restante#<s>3#...",
                    "{C:attention,s:0.8}+#2#{} {C:inactive,s:0.8}ranura#<s>2# de consumible mientras se posea{}",
                }
            },
            c_bof_trout_b = {
                name = "Trucha Arcoíris {X:big}Grande",
                text = {
                    "{C:white,X:mult}X#1#{} Multi",
                    "{C:inactive}#3# ronda#<s>3# restante#<s>3#...",
                    "{C:attention,s:0.8}+#2#{} {C:inactive,s:0.8}ranura#<s>2# de consumible mientras se posea{}",
                }
            },
            c_bof_goldfish_b = {
                name = "Pez Dorado {X:big}Grande",
                text = {
                    "Gana {C:money}$#1#{}",
                    "{C:inactive}#3# ronda#<s>3# restante#<s>3#...",
                    "{C:attention,s:0.8}+#2#{} {C:inactive,s:0.8}ranura#<s>2# de consumible mientras se posea{}",
                }
            },
            c_bof_bass_l = {
                name = "Perca Americana {X:legendary}Legendaria",
                text = {
                    "Otorga {C:chips}+Fichas{} iguales a la suma {C:attention}total{}",
                    "de fichas de {C:attention}todas las cartas{} de tu baraja,",
                    "{C:attention,s:0.8}+#1#{} {C:inactive,s:0.8}ranura#<s>1# de consumible mientras se posea{}",
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            c_bof_betta_l = {
                name = "Betta {X:legendary}Legendario",
                text = {
                    "Otorga {C:mult}+Multi{} igual al Multi {C:attention}total{}",
                    "que suman todas las {C:attention}manos de póker{}",
                    "visibles",
                    "{C:attention,s:0.8}+#1#{} {C:inactive,s:0.8}ranura#<s>1# de consumible mientras se posea{}",
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            c_bof_trout_l = {
                name = "Trucha Arcoíris {X:legendary}Legendaria",
                text = {
                    "Los Comodines y {C:attention}otros{} consumibles",
                    "otorgan {C:white,X:mult}X#1#{} Multi cada uno,",
                    "{C:attention,s:0.8}+#2#{} {C:inactive,s:0.8}ranura#<s>1# de consumible mientras se posea{}",
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            },
            c_bof_goldfish_l = {
                name = "Pez Dorado {X:legendary}Legendario",
                text = {
                    "Otorga dinero igual a la cantidad",
                    "{C:attention}actual{} de {C:money}interés{} que",
                    "se ganaría al jugar una mano,",
                    "{C:attention,s:0.8}+#1#{} {C:inactive,s:0.8}ranura#<s>1# de consumible mientras se posea{}",
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                }
            }
        },
        -- coupons
        Voucher = {
            v_bof_dark_alley = {
                name = "Callejón Oscuro",
                text = {
                    {
                        "Los {C:attention}consumibles{} en la tienda",
                        "pueden ser raramente {C:dark_edition}Negativos{}",
                    },
                    {
                        "Las cartas {C:spectral}Espectrales{} pueden",
                        "aparecer raramente en la tienda",
                    }
                }
            },
            v_bof_illegal_wares = {
                name = "Mercancía Ilegal",
                text = {
                    "Las cartas {C:spectral}Espectrales{}, los",
                    "consumibles {C:dark_edition}Negativos{},",
                    "y los Comodines {C:dark_edition}Negativos{}",
                    "aparecen {C:attention}3X{} más a menudo"
                },
                unlock = {
                    "Ten al menos",
                    "{C:attention}3 cartas {C:spectral}Espectrales{}",
                    "al mismo tiempo"
                }
            },
            v_bof_unboxing = {
                name = "Desempaquetado",
                text = {
                    "Los {C:attention}Paquetes Potenciadores{} pueden",
                    "aparecer en las ranuras de la tienda",
                }
            },
            v_bof_shoplifting = {
                name = "Reventa",
                text = {
                    "Los {C:attention}Vales{} pueden aparecer",
                    "raramente en las ranuras de la tienda",
                },
                unlock = {
                    "Omite un total de",
                    "{C:attention}30{} Paquetes Potenciadores",
                    "{C:inactive}(#1#)"
                }
            },
            v_bof_scratch_off = {
                name = "Raspa y Gana",
                text = {
                    "Cada {C:attention}#<o>1#{} renovación en la tienda,",
                    "{C:attention}reestablece{} todos los {C:attention}Paquetes Potenciadores{} presentes"
                }
            },
            v_bof_lottery_ticket = {
                name = "Boleto de Lotería",
                text = {
                    "Cada {C:attention}#<o>1#{} renovación en la tienda,",
                    "{C:attention}reestablece{} todos los {C:attention}Vales{} presentes"
                },
                unlock = {
                    "Canjea {C:attention}3{} Vales",
                    "en la misma Apuesta"
                }
            },
            v_bof_ice_bucket = {
                name = "Cubeta de Hielo",
                text = {
                    "Las cartas {C:fish}Pez{} duran",
                    "una ronda {C:attention}adicional{}"
                }
            },
            v_bof_buried_treasure = {
                name = "Tesoro Enterrado",
                text = {
                    "Las cartas {C:fish}Pez{} otorgan",
                    "una ranura de consumible {C:attention}adicional{}"
                },
                unlock = {
                    "Deja que {C:attention}5 cartas {C:fish}Pez{}",
                    "caduquen en una partida"
                }
            }
        },
        -- enemies (& finishers)
        Blind = {
            bl_bof_dominant = {
                name = "El Dominante",
                text = {
                    "Las cartas con Sello",
                    "no tienen efecto"
                }
            },
            bl_bof_risk = {
                name = "El Riesgo",
                text = {
                    "El comodín del extremo derecho",
                    "está deshabilitado"
                }
            },
            bl_bof_irradiated = {
                name = "El Irradiado",
                text = {
                    "Las cartas jugadas no dan",
                    "sus fichas base al anotar"
                }
            },
            bl_bof_change = {
                name = "El Cambio",
                text = {
                    "Las cartas mejoradas se",
                    "sacan boca abajo"
                }
            },
            bl_bof_tiny = {
                name = "El Pequeño",
                text = {
                    "La Ciega Pequeña de la",
                    "siguiente Apuesta es grande",
                    "y no se puede omitir"
                }
            },
            bl_bof_damping = {
                name = "La Amortiguación",
                text = {
                    "Los comodines Raros están",
                    "deshabilitados hasta la mano final"
                }
            },
            bl_bof_viscous = {
                name = "La Viscosa",
                text = {
                    "Aplica permanentemente un debilitamiento",
                    "a una carta que anote al azar por mano"
                }
            },
            bl_bof_angle = {
                name = "El Ángulo",
                text = {
                    "Tamaño de Ciega +0.1X por carta descartada,",
                    "-1 descarte"
                }
            },
            bl_bof_array = {
                name = "La Matriz",
                text = {
                    "Destruye un consumible",
                    "al jugar la mano"
                }
            },
            bl_bof_curve = {
                name = "La Curva",
                text = {
                    "Disminuye el nivel de",
                    "las manos de póker descartadas"
                }
            },
            bl_bof_decay = {
                name = "La Decadencia",
                text = {
                    "Las cartas no pueden",
                    "reorganizarse"
                }
            },
            bl_bof_average = {
                name = "El Promedio",
                text = {
                    "#1# en #2# prob. de descartar",
                    "cartas modificadas al sacarlas"
                }
            },
            bl_bof_frequent = {
                name = "El Frecuente",
                text = {
                    "Las cartas de palo {C:attention}#1#{}",
                    "se sacan boca abajo"
                }
            },
            bl_bof_random = {
                name = "El Aleatorio",
                text = {
                    "Baraja las cartas en",
                    "la mano jugada"
                }
            },
            bl_bof_useless = {
                name = "El Inútil",
                text = {
                    "Reduce a la mitad el valor",
                    "de venta de todos los Comodines"
                }
            },
            bl_bof_irrational = {
                name = "El Irracional",
                text = {
                    "Las cartas en mano",
                    "se barajan"
                }
            },
            bl_bof_dense = {
                name = "El Denso",
                text = {
                    "La primera carta que anota",
                    "está debilitada"
                }
            },
            bl_bof_stress = {
                name = "El Estrés",
                text = {
                    "El Vale no puede",
                    "reabastecerse en la siguiente Apuesta"
                }
            },
            bl_bof_terminal = {
                name = "El Terminal",
                text = {
                    "La última categoría que anotó",
                    "está debilitada en la siguiente mano"
                }
            },
            bl_bof_circuit = {
                name = "El Circuito",
                text = {
                    "Solo tres cartas pueden",
                    "estar visibles a la vez"
                }
            },
            bl_bof_particle = {
                name = "La Partícula",
                text = {
                    "Las Ciegas de la siguiente",
                    "Apuesta no se pueden omitir"
                }
            },
            bl_bof_golden = {
                name = "El Dorado",
                text = {
                    "Las cartas en mano al final",
                    "de la ronda dan -$3"
                }
            },
            bl_bof_square = {
                name = "El Cuadrado",
                text = {
                    "La mano jugada debe contener",
                    "al menos 4 cartas que anoten"
                }
            },
            bl_bof_wave = {
                name = "La Ola",
                text = {
                    "El comodín del extremo derecho",
                    "se Fija cuando se juega la mano final"
                }
            },
            bl_bof_resistance = {
                name = "La Resistencia",
                text = {
                    "No hay ganancia de Ciega, Manos,",
                    "Descartes ni Interés"
                }
            }
        },
        Other = {
            p_bof_tackle_normal = {
                name = "Paquete de Pescador",
                text = {
                    "Escoge {C:attention}#1#{} de hasta",
                    "{C:attention}#2# cartas{} de {C:fish}Pez{}"
                }
            },
            p_bof_tackle_jumbo = {
                name = "Paquete de Pescador Jumbo",
                text = {
                    "Escoge {C:attention}#1#{} de hasta",
                    "{C:attention}#2# cartas{} de {C:fish}Pez{}"
                }
            },
            p_bof_fry = {
                name = "Paquete Frito",
                text = {
                    "Escoge {C:attention}#1#{} de hasta",
                    "{C:attention}#2# cartas{} de {C:fish}Pez{} {C:white,X:small}Pequeño{}"
                }
            },
            p_bof_hooked = {
                name = "Paquete de Cebo",
                text = {
                    "Escoge {C:attention}#1#{} de hasta",
                    "{C:attention}#2# cartas{} de {C:fish}Pez{} {C:white,X:big}Grande{}"
                }
            },
            k_bof_perkeo_legendary = {
                name = "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
                text = {
                    "{C:inactive,s:0.8}(No puede copiar peces {C:white,s:0.8,X:legendary}Legendarios{C:inactive,s:0.8})"
                }
            },
            k_bof_tom_sell = {
                text = {
                    "{C:inactive,s:0.8}(No se puede vender cuando las ranuras están llenas)"
                }
            },
            k_bof_modification = {
                name = "Modificación",
                text = {
                    "{C:enhanced}Mejora{},",
                    "{C:dark_edition}Edición{}, {C:attention}Sello{}"
                }
            },
            bof_baltrame_spades = {
                name = "Espadas",
                text = {
                    "Las cartas jugadas de palo",
                    "{C:spades}Espadas{} crean una",
                    "{C:spectral}Etiqueta Etérea{} al anotar"
                }
            },
            bof_baltrame_hearts = {
                name = "Corazones",
                text = {
                    "Las cartas jugadas de palo",
                    "{C:hearts}Corazones{} crean una",
                    "{C:tarot}Etiqueta Encantada{} al anotar"
                }
            },
            bof_baltrame_clubs = {
                name = "Tréboles",
                text = {
                    "Las cartas jugadas de palo",
                    "{C:clubs}Tréboles{} crean una",
                    "{C:planet}Etiqueta de Meteoro{} al anotar"
                }
            },
            bof_baltrame_diamonds = {
                name = "Diamantes",
                text = {
                    "Las cartas jugadas de palo",
                    "{C:diamonds}Diamantes{} crean una",
                    "{C:attention}Etiqueta Estándar{} al anotar"
                }
            }
        }
    },
    misc = {
        dictionary = {
            b_fish_cards = "Cartas de Pez",
            k_active_ex = "¡Activo!",
            k_inactive_el = "Inactivo...",
            k_ready_ex = "¡Listo!",
            k_destroyed_ex = "¡Destruido!",
            k_alarm_ex = "¡Alarma lista!",
            k_erased_ex = "¡Borrado!",
            k_sticker_ex = "¡Sticker aplicado!",
            k_bof_tackle = "Paquete de Pescador",
            k_bof_fry = "Paquete Frito",
            k_bof_hooked = "Paquete de Cebo",
            k_fish = "Pez",
            bl_bof_square = "Debe contener 4 cartas que anoten",
            bl_bof_terminal = "La última categoría que anotó está debilitada",
            bof_most_common_suit = "(palo más común de la baraja)",

            bof_bof = "Bundles Of Fun",
            bof_appetizers = "Aperitivos",
            bof_jesters = "Bufones",
            bof_normalities = "Normalidades",
            bof_fables = "Fábulas",
            bof_flats = "Planicies",
            bof_minnows = "Peces",
            bof_coupons = "Cupones",
            bof_enemies = "Enemigos",
            -- bof_finishers = "Finishers",
            -- bof_games = "Games"
        }
    }
}
