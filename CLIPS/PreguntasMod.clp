;DEFFUNCTIONS
(defmodule PreguntasMod (import MAIN defclass ?ALL))

(deffunction PreguntasMod::question-instance ()
   (bind ?answer (readline))
   (if (lexemep ?answer) 
       then (bind ?answer ?answer))
   (while (not (lexemep ?answer)) do
        (printout t "Introduce a valid string" crlf)
        bind ?answer (readline))
?answer)

(deffunction PreguntasMod::add-preference (?classtype ?slot ?count ?visitor_instance)
    (bind ?answer (question-instance))
    (while (not(eq ?answer "done")) do
        (bind ?aux (find-instance ((?inst ?classtype)) (eq (lowcase ?inst:?slot) (lowcase ?answer))))
        (bind ?mslot (send ?visitor_instance get-Preferences))
        (bind ?already (member$ ?aux ?mslot))

        (printout t ?aux crlf)
        (if (not ?already) then    
        (slot-insert$ ?visitor_instance Preferences ?count ?aux)
        (bind ?count (+ ?count 1)))
        (bind ?answer (question-instance))
    )
)

(deffunction PreguntasMod::ask-question-with-values-int (?question $?allowed-values)
   (printout t ?question crlf)
   (printout t "Possible values: [" 1 "," (length$ ?allowed-values)"]")
   (printout t $?allowed-values crlf)
   (bind ?answer (read))
   (if (integerp ?answer) 
       then (bind ?answer ?answer))
   (while (or (< ?answer 1) (> ?answer (length$ ?allowed-values))) do
      (printout t ?question crlf)
      (printout t "Possible values: [" 1 "," (length$ ?allowed-values)"]")
      (printout t $?allowed-values crlf)    
      (bind ?answer (read))
      (if (integerp ?answer) 
          then (bind ?answer ?answer)))
   ?answer)

(deffunction PreguntasMod::ask-question-with-values (?question $?allowed-values)
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
   (printout t ?question)
   (bind ?answer (readline))
   (if (lexemep ?answer) 
       then (bind ?answer ?answer))
   (while (not (lexemep ?answer)) do
      (printout t "Introduce a string" crlf)
      (printout t ?question)
      (bind ?answer (readline))
      (if (lexemep ?answer) 
          then (bind ?answer ?answer)))
   ?answer)

(deffunction PreguntasMod::ask-question-integer (?question)
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
          then (bind ?answer ?answer)))
   ?answer)

(deffunction PreguntasMod::yes-or-no-p (?question)
   (bind ?response (ask-question-with-values ?question yes no y n))
   (if (or (eq ?response yes) (eq ?response y))
       then TRUE 
       else FALSE))

;//DEFRULES

(defrule PreguntasMod::visitor-questions ""
(declare (salience -9999))
   =>
   (bind ?visitor_name
      (ask-question-string "What is your name? "))
   (bind ?number_of_people
      (ask-question-integer "How many people is your group composed of? "))
   (bind ?days
      (ask-question-integer "How many days are you going to stay? "))
   (bind ?time
      (ask-question-integer "How long are you going to stay each day (in minutes)? "))
   ;//////////////
   ;BEGIN TEST
   ;//////////////
   (bind ?points 0)
   (printout t "Let's see how much you know about art..." crlf)
   (printout t ?points crlf)
   (bind ?response 
      (ask-question-with-values-int "Who is the author of 'The Lyly Pads'? "
                    "Monet" "Manet"))
      (if(eq ?response 1) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf)
   (bind ?response
      (ask-question-with-values-int "Which style does the painting 'In the car' by Roy Lichtenstein belong to? "
                    "Hyperrealism" "Op-Art" "Pop-Art" "Graffiti"))
      (if(eq ?response 3) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf) 
   (bind ?response
      (ask-question-with-values-int "Who composed 'Moonlight Sonata'? "
                    "Mozart" "Bach" "Beethoven" "Brahms"))
      (if(eq ?response 3) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf)   
   (bind ?response
      (ask-question-with-values-int "Which of the following paintings belongs to the modernism? "
                    "Penitent Magdalena" "The Virgin" "Portrait of a philosopher" "Roe with a landscape in the background"))
      (if(eq ?response 2) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf) 
   (bind ?response
      (ask-question-with-values-int "Where is the 'Monument to the Little Mermaid' located?" "Copenhague" "Berlin" "Stockholm" "Oslo"))
      (if(eq ?response 1) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf)
   (bind ?response
      (ask-question-with-values-int "What's the name of a famous Edvard Munch picture?" "The Terror" "The Scream" "The Wind" "The Bridge"))
      (if(eq ?response 2) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf)
   (bind ?response
      (ask-question-with-values-int "Which styles does the Notre Dame catheral combine?" "Romanic and gothic" "Gothic and baroque" "Romantic and rococo" "Byzantine and gothic"))
      (if(eq ?response 1) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf)
   (bind ?response
      (ask-question-with-values-int "Which style does Gustav Klimpt represent?" "Postmodernism" "Art Nouveau"))
      (if(eq ?response 2) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf)
   (bind ?response
      (ask-question-with-values-int "Sandro Botticelli painted the birth of which of these goddesses?" "Artemis" "Venus" "Hera" "Atenea"))
      (if(eq ?response 2) then (bind ?points (+ ?points 10)))  
   (printout t ?points crlf)
   (bind ?response
      (ask-question-with-values-int "Which of the following paintings from Dalí features a melting clock?" "The first days of spring" "The persistence of memory" "Living dead nature" "The accomodations of the wishes"))
      (if(eq ?response 2) then (bind ?points (+ ?points 10)))  
   (printout t "Total points: " ?points crlf)   
    (if(> ?points 80)
        then(printout t "Well done you little art nerd!" crlf)
    else (if(> ?points 40)
        then(printout t "Meeeh, that was okay I guess..." crlf)
    else (printout t "I don't know why you are wasting your money in an art museum if you don't know anything, but hey, it's your money" crlf)))
   
    (bind ?visitor_instance (make-instance visitor of Visitor))
    (send ?visitor_instance put-Visitor+Name ?visitor_name)
    (send ?visitor_instance put-Days ?days)
    (send ?visitor_instance put-Duration ?time)
    (send ?visitor_instance put-Number+of+People ?number_of_people)
    (send ?visitor_instance put-Knowledge ?points)

    (bind ?count 1)
    (printout t "Alright, let's check your preferences now." crlf)
    (printout t "We'll start with the authors. For each author you like, type his name and press ENTER. Type 'done' when you are done" crlf);

    (add-preference Author Author+Name ?count ?visitor_instance)
    
    (printout t "Good. Now same thing for the styles. For each style you like, type its name and press ENTER. Type 'done' when you are done" crlf);
    (add-preference Style Style+Name ?count ?visitor_instance)

    (printout t "Almost done. We also need to know which periods you prefer. For each period you like, type its name and press ENTER. Type 'done' when you are done" crlf);
    (add-preference Period Period+Name ?count ?visitor_instance)

    (printout t "Last step! Tell us about the topics you like the most. For each topic you like, type its name and press ENTER. Type 'done' when you are done" crlf);
    (add-preference Topic Topic+Name ?count ?visitor_instance)

)