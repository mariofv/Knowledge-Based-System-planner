(defmodule PreguntasMod 
"Este módulo se ocupa de adquirir la información necesaria del visitante."

    (import MAIN defclass ?ALL)
    (import MAIN deftemplate YearFilters NationalityFilters)
)

;//////////////
;FUNCIONES ///
;////////////

(deffunction PreguntasMod::question-instance () 
"Función para una pregunta que se responde con string"

   (bind ?answer (readline))
   (if (lexemep ?answer) 
       then (bind ?answer ?answer))
   (while (not (lexemep ?answer)) do
        (printout t "Introduce a valid string" crlf)
        bind ?answer (readline))
?answer)

(deffunction PreguntasMod::add-question-with-values-int-extra (?maxindex) 
"Función para las preguntas con múltiples opciones que se responden por enteros"

   (bind ?answer (read))
   (bind ?out 0)
   (if (lexemep ?answer) then
       (if (eq ?answer done) then
            (bind ?out -1)
            (bind ?answer -1)
       )
   )
   (if (integerp ?answer) 
       then (bind ?answer ?answer)
       else (bind ?answer 0)
   )
   (while (and (not(= ?out -1)) (or (< ?answer 1) (> ?answer ?maxindex)) ) do 
      (printout t "Possible values: [" 1 "," ?maxindex "]" crlf)
      (bind ?answer (read))
      (if (lexemep ?answer) then
          (if (eq ?answer done) then 
            (bind ?out -1)
            (bind ?answer -1)
          )
      (if (integerp ?answer) 
          then (bind ?answer ?answer)
          else (bind ?answer 0))
      )
   )
   (if (eq ?out -1) then
        (bind ?answer -1))
   ?answer
)


(deffunction PreguntasMod::add-preference-number (?classtype ?slot ?count ?visitor_instance $?array) 
"Añade preferencias de un tipo a la instancia de visitante. La pregunta se responde con números"

    (bind ?answer (add-question-with-values-int-extra (length$ ?array)))
    (while (not(= ?answer -1)) do
        (bind ?aux (nth$ ?answer ?array))
        (bind ?mslot (send ?visitor_instance get-Preferences))
        (bind ?already (member$ ?aux ?mslot))

        (printout t ?aux crlf)
        (if (not ?already) then    
            (slot-insert$ ?visitor_instance Preferences ?count ?aux)
            (bind ?count (+ ?count 1))
        )
        (bind ?answer (add-question-with-values-int-extra (length$ ?array)))
    )
)

(deffunction PreguntasMod::nationality-filter($?array) 
"Filtro de nacionalidades de autor"

    (printout t "Possible values:" crlf)
    (printout t "------------------------------------" crlf)
    (loop-for-count (?i 1 (length$ ?array)) do
        (printout t ?i ". ")
        (printout t (send (nth$ ?i ?array) get-Country+name) crlf)
    )
    (printout t "------------------------------------" crlf)
   
    (bind $?bools (create$ 0))
    (loop-for-count (?i 2 (length$ ?array)) do
        (bind $?bools (insert$ ?bools 1 0))
    )
    (bind ?answer (add-question-with-values-int-extra (length$ ?array)))
    (while (not(= ?answer -1)) do
        (bind ?aux (nth$ ?answer ?array))
        (if (eq (nth$ ?answer ?bools) 0) then
            (assert (NationalityFilters (nationality ?aux)))
            (bind $?bools (replace$ ?bools ?answer ?answer 1))
        )
        (printout t "Possible values:" crlf)
        (printout t "------------------------------------" crlf)
        (loop-for-count (?i 1 (length$ ?array)) do
            (printout t ?i ". ")
            (printout t (send (nth$ ?i ?array) get-Country+name) crlf)
        )
        (printout t "------------------------------------" crlf)
        (bind ?answer (add-question-with-values-int-extra (length$ ?array)))
    )
)

(deffunction PreguntasMod::ask-question-with-values-int (?question $?allowed-values) 
"Función para preguntas que se responden con un entero de entre una lista de valores posibles"

   (printout t ?question crlf)
   (printout t "Possible values: [" 1 "," (length$ ?allowed-values)"]")
   (printout t $?allowed-values crlf)
   (bind ?answer (read))
   (if (lexemep ?answer) then
       (bind ?answer -1)
   )
   (if (integerp ?answer) 
       then (bind ?answer ?answer)
   )
   (while (or (< ?answer 1) (> ?answer (length$ ?allowed-values))) do
      (printout t ?question crlf)
      (printout t "Possible values: [" 1 "," (length$ ?allowed-values)"]")
      (printout t $?allowed-values crlf)    
      (bind ?answer (read))
      (if (lexemep ?answer) then
          (bind ?answer -1)
      )
      (if (integerp ?answer) 
          then (bind ?answer ?answer))
   )
   ?answer)


(deffunction PreguntasMod::ask-question-with-values (?question $?allowed-values) 
"Función para preguntas que se responden con string y con una serie de valores posibles"

   (printout t ?question crlf)
   (printout t "Possible values: ")
   (printout t $?allowed-values crlf)
   (bind ?answer (readline))
   (if (lexemep ?answer) 
       then (bind ?answer ?answer))
   (while (not (member ?answer ?allowed-values)) do
      (printout t ?question crlf)
      (printout t "Possible values: ")
      (printout t $?allowed-values crlf)    
      (bind ?answer (readline))
      (if (lexemep ?answer) 
          then (bind ?answer ?answer)))
   ?answer)

(deffunction PreguntasMod::ask-question-string (?question) 
"Función para preguntas que se responden con una string"

   (printout t ?question)
   (bind ?answer (readline))
   (if (lexemep ?answer) 
       then (bind ?answer ?answer)
   )
   (while (not (lexemep ?answer)) do
      (printout t "Introduce a string" crlf)
      (printout t ?question)
      (bind ?answer (readline))
      (if (lexemep ?answer) 
          then (bind ?answer ?answer)
      )
   )
   ?answer)

(deffunction PreguntasMod::ask-question-integer (?question)
"Función para preguntas que se responden con un entero"

   (printout t ?question)
   (bind ?answer (read))
   (if (integerp ?answer) 
       then (if (> ?answer 1) then (bind ?answer ?answer))
   )
   (while (or(not (integerp ?answer)) (< ?answer 1))  do
      (if (not (integerp ?answer)) then (printout t "Introduce an integer" crlf)
      else (if (< ?answer 1) then (printout t "Introduce an integer bigger than 0" crlf) 
       ))
      (printout t ?question)
      (bind ?answer (read))
      (if (integerp ?answer) 
          then (bind ?answer ?answer)
      )
   )
   ?answer)

(deffunction PreguntasMod::yes-or-no-p (?question)
"Función para preguntas que se responden con sí o no"

   (bind ?response (ask-question-with-values ?question "yes" "no" "y" "n"))
   (if (or (eq ?response "yes") (eq ?response "y"))
       then TRUE 
       else FALSE)
)

;///////////
;REGLAS ///
;/////////

(defrule PreguntasMod::visitor-questions 
"Regla que se encarga de adquirir toda la información necesaria del visitante mediante
pretuntas."

(declare (salience -9999))
   =>
   (bind ?visitor_name
      (ask-question-string "Como te llamas? "))
   (bind ?number_of_people
      (ask-question-integer "De cuanta gente se compone tu grupo? "))
   (bind ?children
      (yes-or-no-p "Hay ninos en tu grupo?"))
   (bind ?days
      (ask-question-integer "Cuantos dias vais a estar? "))
   (bind ?time
      (ask-question-integer "Cuanto vais a estar cada dia (en horas)? "))
   ;//Filtro del Año 
  (bind ?yearfilter
      (yes-or-no-p "Quereis filtrar los cuadros por anos?"))
   (if(eq ?yearfilter TRUE) then
       (bind ?year1 (ask-question-integer "Introduce el primer ano del intervalo: "))
       (bind ?year2 (ask-question-integer "Introduce el ultimo ano del intervalo: "))
       (while (< ?year2 ?year1) 
           (printout t "El ultimo ano ha de ser mayor que el primero" crlf);
           (bind ?year2 (ask-question-integer "Introduce el ultimo ano del intervalo : "))
       )
       (assert (YearFilters (firstYear ?year1) (lastYear ?year2)))
   else 
       (assert (YearFilters (firstYear -1) (lastYear 9999)))
   ) 
   ;//Filtro de Nacionalidad
   (bind ?nationalityfilter
       (yes-or-no-p "Quieres filtrar los cuadros por nacionalidad del autor?"))
   (if (eq ?nationalityfilter TRUE) then
        (bind $?nationalities (find-all-instances((?m Country)) TRUE))
        (nationality-filter $?nationalities)
   )
   ;//////////////
   ;Empieza el test para determinar el conocimiento del visitante
   ;//////////////
   (bind ?points 0)
   (printout t "Veamos cuanto sabeis sobre arte..." crlf)
   (printout t ?points crlf)
   (bind ?response 
      (ask-question-with-values-int "Quien es el autor de los nenufares? "
                    "Monet" "Manet"))
      (if(eq ?response 1) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf)
   (bind ?response
      (ask-question-with-values-int "A que genero pertenece la obra 'En el coche' de Roy Lichtenstein? "
                    "Hiperrealismo" "Op-Art" "Pop-Art" "Graffiti"))
      (if(eq ?response 3) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf) 
   (bind ?response
      (ask-question-with-values-int "Quien compuso 'Moonlight Sonata'? "
                    "Mozart" "Bach" "Beethoven" "Brahms"))
      (if(eq ?response 3) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf)   
   (bind ?response
      (ask-question-with-values-int "Cual de estas pinturas pertenece al modernismo? "
                    "Magdalena Penitente" "The Joven" "Retrato de un filosofo" "Roe con un paisaje en el fondo"))
      (if(eq ?response 2) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf) 
   (bind ?response
      (ask-question-with-values-int "Donde se ubica el monumento a la Sirenita de los cuentos de Andersen?" "Copenhague" "Berlin" "Estocolmo" "Oslo"))
      (if(eq ?response 1) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf)
   (bind ?response
      (ask-question-with-values-int "Como se llama la famosa pintura de Edvard Munch" "El terror" "El grito" "El viento" "El puente"))
      (if(eq ?response 2) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf)
   (bind ?response
      (ask-question-with-values-int "Que estilos combina la Catedral de Notre Dame?" "Romanico y gotico" "Gotico y barroco" "Romantico y gotico" "Bizantino y gotico"))
      (if(eq ?response 1) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf)
   (bind ?response
      (ask-question-with-values-int "Gustav Klimpt es un tipico representante del..." "Postmodernismo" "Art Nouveau"))
      (if(eq ?response 2) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf)
   (bind ?response
      (ask-question-with-values-int "Sandro Botticelli pinto el nacimiento de cual de estas diosas?" "Artemis" "Venus" "Hera" "Atenea"))
      (if(eq ?response 2) then (bind ?points (+ ?points 10)))  
   (printout t ?points crlf)
   (bind ?response
      (ask-question-with-values-int "Cual de estas pinturas de Dali contiene un reloj derretido?" "Los primeros dias de primavera" "La persistencia de la memoria" "Naturaleza muerta viviente" "La acomodacion de los deseos"))
      (if(eq ?response 2) then (bind ?points (+ ?points 10)))  
   (printout t "Total points: " ?points crlf)   
    (if(> ?points 80)
        then(printout t "Bien hecho pequeño friki del arte!" crlf)
    else (if(> ?points 40)
        then(printout t "Meeeh, supongo que no esta mal..." crlf)
    else (printout t "No se para que vienes a un museo de arte sin tener ni idea, pero eh, es tu dinero." crlf)))
   
    ;Se crea la instancia del visitante y se le añade la información que ya tenemos
    (bind ?visitor_instance (make-instance visitor of Visitor))
    (send ?visitor_instance put-Visitor+name ?visitor_name)
    (send ?visitor_instance put-Days ?days)
    (send ?visitor_instance put-Duration (* 3600 ?time))
    (send ?visitor_instance put-Number+of+people ?number_of_people)
    (send ?visitor_instance put-Knowledge ?points)
    (send ?visitor_instance put-Children ?children)

    ;Empezamos a comprobar las preferencias del visitante y a añadirlas

    ;Comprobamos las preferencias del visitante respecto a autores
    (bind ?count 1)
    (printout t "Muy bien, comprobemos tus preferencias." crlf)
    (printout t "Empezaremos por los autores. Para cada autor que te guste, escribe su numero y pulsa ENTER. Cuando hayas acabado escribe 'done' y pulsa ENTER." crlf);
    (printout t "Aqui estan todos los autores disponibles:" crlf)
    (bind $?aux (find-all-instances((?m Author)) TRUE))
    (loop-for-count (?i 1 (length$ ?aux)) do
        (printout t ?i ". ")
        (printout t (send (nth$ ?i ?aux) get-Author+name) crlf)
    )
    (add-preference-number Author Author+name ?count ?visitor_instance $?aux)

    ;Comprobamos las preferencias del visitante respecto a estilos
    (printout t "Bien, ahora lo mismo con los estilos. Para cada estilo que te guste, escribe su numero y pulsa ENTER. Cuando hayas acabado escribe 'done' y pulsa ENTER." crlf);
    (printout t "Aqui estan todos los estilos disponibles:" crlf)
    (bind $?aux (find-all-instances((?m Style)) TRUE))
    (loop-for-count (?i 1 (length$ ?aux)) do
        (printout t ?i ". ")
        (printout t (send (nth$ ?i ?aux) get-Style+name) crlf)
    )    
    (add-preference-number Style Style+name ?count ?visitor_instance $?aux)

    ;Comprobamos las preferencias del visitante respecto a periodos pictóricos
    (printout t "Ya casi estamos. Tambien necesitamos saber que epocas prefieres. Para cada epoca que te guste, escribe su numero y pulsa ENTER. Cuando hayas acabado escribe 'done' y pulsa ENTER." crlf);
    (printout t "Aqui estan todas las epocas disponibles:" crlf)
    (bind $?aux (find-all-instances((?m Period)) TRUE))
    (loop-for-count (?i 1 (length$ ?aux)) do
        (printout t ?i ". ")
        (printout t (send (nth$ ?i ?aux) get-Period+name) crlf)
    )
    (add-preference-number Period Period+name ?count ?visitor_instance $?aux)

    ;Comprobamos las preferencias del visitante respecto a temas
    (printout t "Ultimo paso! Dinos que temas te gustan mas. Para cada tema que te guste, escribe su numero y pulsa ENTER. Cuando hayas acabado escribe 'done' y pulsa ENTER." crlf);
    (printout t "Aqui estan todos los temas disponibles: " crlf)
    (bind $?aux (find-all-instances((?m Topic)) TRUE))
    (loop-for-count (?i 1 (length$ ?aux)) do
        (printout t ?i ". ")
        (printout t (send (nth$ ?i ?aux) get-Topic+name) crlf)
    ) 
    (add-preference-number Topic Topic+name ?count ?visitor_instance $?aux)

)