; SISTEMA CONTROLADOR DE UNA VIVIENDA INTELIGENTE


; Variable global que muestra la temperatura actual dentro de la vivienda
(defglobal ?*temperatura* = 20)


; Funci�n que se aplica cuando est� bajando la temperatura.
; Comprueba si hay menos de 20 grados para que el calefactor suba a 1 grado m�s
; la temperatura.
(deffunction bajando () 
	(if (< ?*temperatura* 20) 
	then (++ ?*temperatura*)
	      (printout t "Subiendo temperatura." crlf)
	     (printout t "Temperatura actual: "?*temperatura* " grados" crlf)
	)
)


; Funci�n que se aplica cuando est� subiendo la temperatura.
; Comprueba si hay m�s de 20 grados para que el calefactor baje a 1 grado m�s
; la temperatura.
(deffunction subiendo () 
	(if (> ?*temperatura* 20) 
	then (-- ?*temperatura*)
	      (printout t "Bajando temperatura." crlf)
		(printout t "Temperatura actual: "?*temperatura* " grados" crlf)
	)
)



; Regla que cierra la puerta si est� abierta y la vivienda vac�a.
(defrule puertaCerrada
	(and
		(vivienda vacia)
		(puerta abierta)
	)
	=>
	(printout t "Cerrar la puerta." crlf)
	(retract-string "(puerta abierta)")
	(assert (puerta cerrada))
)


; Regla que conecta la alarma si est� desconectada y la vivienda vac�a.
(defrule alarmaConectada
	(and
		(vivienda vacia)
		(alarma desconectada)
	)
	=>
	(printout t "Conectar la alarma." crlf)
	(retract-string "(alarma desconectada)")
	(assert (alarma conectada))
)


; Regla que apaga las luces si est�n encendidas y la vivienda vac�a.
(defrule apagarLuces
	(and
		(vivienda vacia)
		(luz encendida)
	)
	=>
	(printout t "La vivienda esta vacia. Las luces deben estar apagadas." crlf)
	(retract-string "(luz encendida)")
	(assert (luz apagada))
)


; Regla que llama a la polic�a cuando la alarma est� activada.
(defrule llamarPolicia
	(alarma activada)
	=>
	(printout t "Llamar a la policia." crlf)
	(retract-string "(alarma activada)")
	(assert (alarma conectada))
)


; Regla que enciende la nevera si est� apagada y con la puerta cerrada.
(defrule neveraApagada
	(and
		(nevera apagada)
		(puerta-nevera cerrada)
	)
	=>
	(printout t "Encender nevera." crlf)
	(retract-string "(nevera apagada)")
	(assert (nevera encendida))
)

; Regla que cierra la puerta de la nevera si est� abierta y con la nevera funcionando.
(defrule neveraEncendida
	(and
		(nevera encendida)
		(puerta-nevera abierta)
	)
	=>
	(printout t "Cerrar puerta nevera." crlf)
	(retract-string "(puerta-nevera abierta)")
	(assert (puerta-nevera cerrada))
)

; Regla que cierra la puerta del horno si est� abierta y este funcionando.
(defrule hornoEncendido
	(and
		(horno encendido)
		(puerta-horno abierta)
	)
	=>
	(printout t "Cerrar puerta horno." crlf)
	(retract-string "(puerta-horno abierta)")
	(assert (puerta-horno cerrada))
)
