(define (domain Mart)
  (:requirements :typing)
  (:types rover persona suministre assentament base combustible)

  ; Predicates deffinition = "boolean state variables"
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
  
)
