(define (domain Mart)
  (:requirements :typing)
  (:types rover persona suministre assentament base combustible)

  ; Predicates definition = "boolean state variables"
  (:predicates
      (aparcat    ?r - rover      ?b - base)                    ; rover ?r aparcat a ?a
      (l_persona  ?p - persona    ?a - assentament)             ; persona ?p es troba a l'assentament ?a
      (l_sum      ?s - suministre ?a - assentament)             ; suministre ?s es troba a l'assentament ?a
      (rover_buit ?r - rover)                                   ; el rover ?r no porta res
      (rover_1p   ?r - rover      ?p  - persona)                ; el rover ?r porta 1 persona
      (rover_2p   ?r - rover      ?p1 - persona ?p2 - persona)  ; el rover ?r porta 2 persones
      (rover_s    ?r - rover      ?s  - suministre)             ; el rover ?r porta el suministre ?s
      (comb_rest  ?r - rover      ?c  - combustible)            ; el rover ?r te ?c unitats de combustible
  )
  

;;;;;;;;;;;;;;;;;;;;;;;;;no se si posar not aparcat com a effect
(:action pick1person		
:parameters(?x - rover ?b - base ?p - persona ?a - assentament ?p2 - persona)
:precondition (and (aparcat ?r ?b) (l_persona ?p ?a) (or (rover_buit ?r)(rover_1p ?r ?p2)))

:effect(and (not (l_persona ?p ?a)) (rover_1p ?r ?p) (not(rover_buit ?r)))

)

(:action pick2person		;same assentament
:parameters(?x - rover ?b - base ?p1 - persona ?p2 - persona ?a - assentament)
:precondition (and (aparcat ?r ?b) (l_persona ?p1 ?a) (l_persona ?p2 ?a) (rover_buit ?r))

:effect(and (not (l_persona ?p1 ?a)) (not (l_persona ?p2 ?a)) (rover_2p ?r ?p1 ?p2) (not(rover_buit ?r)))

)

(:action picksuministre
:parameters(?x - rover ?b - base ?s - suministre ?a - assentament)
:precondition (and (aparcat ?r ?b) (l_sum ?s ?a) (rover_buit ?r))

:effect(and (not (l_persona ?p ?a)) (rover_1p ?r ?p) (not(rover_buit ?r)))

)

)
