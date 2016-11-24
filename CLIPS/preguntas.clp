
;DEFFUNCTIONS

(deffunction ask-question-with-values (?question $?allowed-values)
   (printout t ?question crlf)
   (printout t "Possible values: ")
   (printout t $?allowed-values crlf)
   (bind ?answer (read))
   (if (lexemep ?answer) 
       then (bind ?answer ?answer))
   (while (not (member ?answer ?allowed-values)) do
      (printout t ?question crlf)
      (printout t "Possible values: ")
      (printout t $?allowed-values crlf)    
      (bind ?answer (read))
      (if (lexemep ?answer) 
          then (bind ?answer ?answer)))
   ?answer)
;noob
(deffunction ask-question-string (?question)
   (printout t ?question)
   (bind ?answer (read))
   (if (lexemep ?answer) 
       then (bind ?answer ?answer))
   (while (not (lexemep ?answer)) do
      (printout t "Introduce a string, you idiot" crlf)
      (printout t ?question)
      (bind ?answer (read))
      (if (lexemep ?answer) 
          then (bind ?answer ?answer)))
   ?answer)

(deffunction ask-question-integer (?question)
   (printout t ?question)
   (bind ?answer (read))
   (if (integerp ?answer) 
       then (bind ?answer ?answer))
   (while (not (integerp ?answer)) do
      (printout t "Introduce an integer, dumbass" crlf)
      (printout t ?question)
      (bind ?answer (read))
      (if (integerp ?answer) 
          then (bind ?answer ?answer)))
   ?answer)

(deffunction yes-or-no-p (?question)
   (bind ?response (ask-question-with-values ?question yes no y n))
   (if (or (eq ?response yes) (eq ?response y))
       then TRUE 
       else FALSE))

;//DEFRULES

(defrule visitor-questions ""
  (initial-fact)
   =>
   (bind ?visitor_name
      (ask-question-string "What is the your name, bitch? "))
   (bind ?number_of_people
      (ask-question-integer "How many people is your group composed of, bitch? "))
   (bind ?days
      (ask-question-integer "How many days are you going to stay, bitch? "))
   (bind ?days
      (ask-question-integer "How long are you going to stay each day (in minutes), bitch? "))
   (bind ?points 0)
   (printout t "Let's see how much you know about art..." crlf)
   (bind ?response 
      (ask-question-with-values "Who is the author of 'The Lyly Pads'? "
                    Monet Manet))
      (if(eq ?response Monet) then (bind ?points (+ ?points 10)))
   (bind ?response
      (ask-question-with-values "Which style does the painting 'In the car' by Roy Lichtenstein belong to? "
                    Hyperrealism Op-Art Pop-Art Graffiti))
      (if(eq ?response Pop-Art) then (bind ?points (+ ?points 10)))
   (bind ?response
      (ask-question-with-values "Who composed 'Moonlight Sonata'? "
                    Mozart Bach Beethoven Brahms))
      (if(eq ?response Beethoven) then (bind ?points (+ ?points 10)))
   (bind ?response
      (ask-question-with-values "Which of the following paintings belongs to the modernism? "
                    "Penitent Magdalena" "The Virgin" "Portrait of a philosopher" "Roe with a landscape in the background"))
      (if(eq ?response "The Virgin") then (bind ?points (+ ?points 10)))
   (bind ?response
      (ask-question-with-values "Where is the 'Monument to the Little Mermaid' located?" Copenhague Berlin Stockholm Oslo))
      (if(eq ?response Copenhague) then (bind ?points (+ ?points 10)))
   (bind ?response
      (ask-question-with-values "What's the name of a famous Edvard Munch picture?" "The Terror" "The Scream" "The Wind" "The Bridge"))
      (if(eq ?response "The Scream") then (bind ?points (+ ?points 10)))
   (bind ?response
      (ask-question-with-values "Which styles does the Notre Dame catheral combine?" "Romanic and gothic" "Gothic and baroque" "Romantic and rococo" "Byzantine and gothic"))
      (if(eq ?response "Romanic and gothic") then (bind ?points (+ ?points 10)))
   (bind ?response
      (ask-question-with-values "Which style does Gustav Klimpt represent?" Postmodernism ArtNouveau))
      (if(eq ?response ArtNouveau) then (bind ?points (+ ?points 10)))
   (bind ?response
      (ask-question-with-values "Sandro Botticelli painted the birth of which of these goddesses?" Artemis Venus Hera Atenea))
      (if(eq ?response Venus) then (bind ?points (+ ?points 10)))  
   (bind ?response
      (ask-question-with-values "Which of the following paintings from Dalí features a melting clock?" "The first days of spring" "The persistence of memory" "Living dead nature" "The accomodations of the wishes"))
      (if(eq ?response "The persistence of memory") then (bind ?points (+ ?points 10)))  
   (printout t "Total points: " ?points crlf)   
    (if(> ?points 80)
        then(printout t "Well done you little art nerd!" crlf)
    else (if(> ?points 40)
        then(printout t "Meeeh, that was okay I guess..." crlf)
    else (printout t "I don't know why you are wasting your money in an art museum if you don't know shit, but hey, it's your money" crlf)))
   

)
   

   



















