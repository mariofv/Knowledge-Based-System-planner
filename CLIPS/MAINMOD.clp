(defmodule MAIN
"Módulo que se encarga de ejecutar los módulos ComplexityMod, HeuristicMod y
VisitaMod."

    (export defclass ?ALL)
    (export deftemplate ?ALL)
)

;///////////
;HECHOS ///
;/////////

(deftemplate AnalyzePainting 
"Hecho que indica el cuadro del cual se tienen que calcular el tiempo de observación
y el interés. Este hecho lo utiliza HeuristicMod."

    (slot painting 
        (type INSTANCE)
        (allowed-classes Painting)
    )
)

(deftemplate AnalyzeVisitor
"Hecho auxiliar que contiene la instancia del visitante. Es necesario para que las
reglas de HeuristicMod se ejecuten por cada cuadro, ya que al haber solo un visitante,
cualquier regla que requiera acceder a los datos de éste sólo se ejecutaría una vez si
no usáramos este hecho."

    (slot visitor 
        (type INSTANCE)
        (allowed-classes Visitor)
    )
)

(deftemplate FinalObservationTime
"Hecho que indica el tiempo de observación calculado en HeuristicMod."

    (slot time
        (type INTEGER)
    )
)

(deftemplate FinalPaintingInterest
"Hecho que indica el interés calculado en HeuristicMod."
    (slot interest
        (type INTEGER)
    )
)

(deftemplate YearFilters
"Hecho que indica el intervalo al cual tiene que pertenecer el año de creación
de los cuadros a visitar."

    (slot firstYear
        (type INTEGER)
    )
    (slot lastYear
        (type INTEGER)
    )
)

(deftemplate NationalityFilters
"Todos los pintores que pintaron algún cuadro que pertenezca a la visita tienen
que ser de alguna nacionalidad indicada por este hecho (si el visitante ha decidido
filtrar por nacionalidad)."

    (slot nationality
        (type INSTANCE)
        (allowed-classes Country)
    )
)

;///////////
;REGLAS ///
;/////////

(defrule InitializeMaxMinPaintingArea 
"Esta regla empieza la ejecución del módulo ComplexityMod."

(declare (salience 200))
=>
    (focus ComplexityMod)
)

(defrule changePreguntasModul
"Esta regla empieza la ejecución del módulo PreguntasMod."

(declare (salience 25))
=>
    (focus PreguntasMod)
)

(defrule AnalyzePainting
"Para cada cuadro que pase los filtros se ejecuta el módulo HeuristicMod."

(declare (salience 0))
    (YearFilters (firstYear ?fy) (lastYear ?ly))
    ?painting <- (object (is-a Painting) (Year+of+creation ?year) (Created+by ?author))
    ?visitor <- (object (is-a Visitor))
    (test (>= ?year ?fy))
    (test (<= ?year ?ly))
    (or
        (not (exists (NationalityFilters)))
        (exists 
            (NationalityFilters (nationality ?nationality))
            (test (eq ?nationality (send ?author get-Nationality)))
        )
    )
=>
    (assert (AnalyzeVisitor (visitor ?visitor)))
    (assert (AnalyzePainting (painting ?painting)))
    (focus HeuristicMod)
)

(defrule FinishAnalyzing
"Cada vez que se calcula el tiempo de observación y el interés de un cuadro, se
indican por pantalla los resultados."

(declare (salience 1))
    ?f1 <- (FinalObservationTime (time ?time))
    ?f2 <- (FinalPaintingInterest (interest ?interest))
    ?f3 <- (AnalyzePainting (painting ?painting))
    ?f4 <- (AnalyzeVisitor)
=>
    (printout t "El cuadro " (send ?painting get-Painting+name) " tiene un interes de " ?interest " y un tiempo de observacion de " ?time " segundos." crlf)
    (send ?painting put-Visitor+interest ?interest)
    (send ?painting put-Observation+time ?time)
    (retract ?f1)
    (retract ?f2)
    (retract ?f3)
    (retract ?f4)
)

(defrule StartVisita
"Una vez se ha calculado el interés y el tiempo de observación para cada cuadro,
se crea la visita a realizar."

(declare (salience -1))
=>
    (focus VisitaMod)
    (assert (Finish-Fact))
)

(defrule FinishProgram
"Cuando se tiene la visita, se le indican al usuario los resultados finales."

(declare (salience 10000))
    ?object <- (object (is-a Day) (Number ?number) (Asigned+paintings $?asignedPaintings) (Asigned+time ?asignedTime))
=>
    (printout t "Los cuadros a visitar en el dia " ?number " con tiempo asignado " ?asignedTime " son" crlf)
    (loop-for-count (?i 1 (length$ ?asignedPaintings)) do
        (bind ?painting (nth$ ?i ?asignedPaintings))
        (printout t "Sala " (send (send ?painting get-Exhibited+in) get-Number) " El cuadro " (send ?painting get-Painting+name) " tiene un interes de " (send ?painting get-Visitor+interest) " y un tiempo de observacion de " (send ?painting get-Observation+time) " segundos." crlf)
    )
    (printout t crlf)
)

(defrule DeleteFilterFacts
"Antes de acabar con la ejecución del programa, se eliminan hechos que no necesitan
guardarse."

(declare (salience 9999))
    ?f <- (NationalityFilters)
    (Finish-Fact)
=>
    (retract ?f)
)

(defrule END
"Antes de acabar con la ejecución del programa, se eliminan hechos que no necesitan
guardarse."

(declare (salience 9998))
    ?f1 <- (Finish-Fact)
    ?f2 <- (YearFilters)
=>
    (retract ?f1)
    (retract ?f2)
)