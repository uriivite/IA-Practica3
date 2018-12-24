(define (domain Mart)
  (:requirements :typing)
  (:types rover persona suministre assentament aparcament)

  ; Predicates deffinition = "boolean state variables"
  (:predicates
      (aparcat    ?r - rover      ?a - aparcament)  ; rover ?r aparcat a ?a
      (l_persona  ?p - persona    ?a - assentament) ; persona ?p es troba a l'assentament ?a
      (l_sum      ?s - suministre ?a - assentament) ; suministre ?s es troba a l'assentament ?a
  )
  
)
