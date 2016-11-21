(defrule iniRule "Pregunta inicial"
(initial-fact)
=>
(printout t "What's your name" crlf)
(assert (name(readline)))
(printout t "I don't like your name" crlf)
)