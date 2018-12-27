(define (domain Mart)
  (:requirements :adl :typing :equality)
  (:types rover persona suministre assentament base combustible)

  (:predicates
      (aparcat    ?r - rover      ?b - base)                        ; rover ?r aparcat a ?a
      (l_rover    ?r - rover      ?a - assentament)                 ; rover ?r localitzat a ?a
      (l_persona  ?p - persona    ?a - assentament)                 ; persona ?p es troba a l'assentament ?a
      (l_sum      ?s - suministre ?a - assentament)                 ; suministre ?s es troba a l'assentament ?a
      (rover_buit ?r - rover)                                       ; el rover ?r no porta res
      (rover_1p   ?r - rover      ?p  - persona)                    ; el rover ?r porta 1 persona
      (rover_2p   ?r - rover      ?p1 - persona     ?p2 - persona)  ; el rover ?r porta 2 persones
      (rover_s    ?r - rover      ?s  - suministre)                 ; el rover ?r porta el suministre ?s
      ;;(comb_rest  ?r - rover      ?c  - combustible)                ; el rover ?r disposa de ?c combustible
      (peticio_p  ?p - persona    ?a - assentament)                 ; la persona ?p ha de ser a l'assentament ?a
      (peticio_s  ?s - suministre ?a - assentament)                 ; el suministre ?s ha de ser a ?a
      (deixo_p    ?p - persona    ?a - assentament)                 ; la persona ?p ha sigut transportada a l'assentament ?a
      (deixo_s    ?s - suministre ?a - assentament)                 ; el suministre ?s ha sigut transportat a l'assentament ?a
  )

(:action translate
  :parameters (?r - rover ?b - base ?a0 - assentament ?a1 - assentament )
  :precondition (or (aparcat ?r ?b) (l_rover ?r ?a0))
  :effect (and (when (aparcat ?r ?b) (not (aparcat ?r ?b)) ) (when (l_rover ?r ?a0)
            (not (l_rover ?r ?a0)) ) (l_rover ?r ?a1) )
)

(:action pick1person
:parameters (?r - rover ?p - persona ?a - assentament ?p2 - persona)
:precondition (and (l_rover ?r ?a) (l_persona ?p ?a) (or (rover_buit ?r) (rover_1p ?r ?p2)))

:effect (and (not (l_persona ?p ?a)) (rover_1p ?r ?p) (when (rover_buit ?r) (not (rover_buit ?r)))
          (when (rover_1p ?r ?p2) (rover_2p ?r ?p ?p2) ))
)

(:action pick2person		
:parameters (?r - rover ?p1 - persona ?p2 - persona ?a - assentament)
:precondition (and (l_rover ?r ?a) (l_persona ?p1 ?a) (l_persona ?p2 ?a) (rover_buit ?r))

:effect (and (not (l_persona ?p1 ?a)) (not (l_persona ?p2 ?a)) (rover_2p ?r ?p1 ?p2)
          (not (rover_buit ?r)) (rover_1p ?r ?p1) (rover_1p ?r ?p2))

)

(:action picksuministre
:parameters(?r - rover ?s - suministre ?a - assentament)
:precondition (and (l_rover ?r ?a) (l_sum ?s ?a) (rover_buit ?r))

:effect (and (not (rover_buit ?r)) (rover_s ?r ?s))

)

(:action descarregar
  :parameters (?r - rover ?p1 - persona ?p2 - persona ?s - suministre ?a - assentament)
  :precondition (and (l_rover ?r ?a) (or (and (rover_1p ?r ?p1) (peticio_p ?p1 ?a))
                                          (and (rover_1p ?r ?p2) (peticio_p ?p2 ?a))
                                          (and (rover_s ?r ?s) (peticio_s ?s ?a) )
                                      )
                )
  :effect (and (when (and (rover_1p ?r ?p1) (rover_1p ?r ?p2)(peticio_p ?p1 ?a)(peticio_p ?p2 ?a))
            (and (not (rover_1p ?r ?p1))
            	(not (rover_1p ?r ?p2))
            	(not (rover_2p ?r ?p1 ?p2))
                (deixo_p ?p1 ?a)
            	(deixo_p ?p2 ?a)
            	(rover_buit ?r)
            )
          )
          (when (and (rover_1p ?r ?p1) (rover_1p ?r ?p2)(peticio_p ?p1 ?a)(not(peticio_p ?p2 ?a)))
              (and (not (rover_1p ?r ?p1))
                    (deixo_p ?p1 ?a)
                    (rover_1p ?r ?p2)
              )
          )
          (when (and (rover_1p ?r ?p1) (rover_1p ?r ?p2)(peticio_p ?p2 ?a)(not(peticio_p ?p1 ?a)))
              (and (not (rover_1p ?r ?p2))
                    (deixo_p ?p2 ?a)
                    (rover_1p ?r ?p1)
              )
          )
          (when (and (rover_1p ?r ?p1) (peticio_p ?p1 ?a))
              (and (not (rover_1p ?r ?p1))
                    (deixo_p ?p1 ?a)
                    (rover_buit ?r)
              )
          )
          (when (and (rover_s ?r ?s) (peticio_s ?s ?a) )
            (and (not (rover_s ?r ?s))
                  (deixo_s ?s ?a)
                  (rover_buit ?r)
            )
          ))

  )

(:action carregar
	:parameters (?r - rover ?b - base  ?a - assentament)
	:precondition (and (not(aparcat ?r ?b)) (l_rover ?r ?a)) 
	:effect (and (aparcat ?r ?b) (not(l_rover ?r ?a)) )
)

)
