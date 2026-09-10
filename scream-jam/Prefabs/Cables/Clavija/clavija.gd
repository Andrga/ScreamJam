extends Node2D
# Bombilla a la que va ligada la clavija
var bombilla: Node2D = null
# Enchufe al que tiene que ir la clavija
var objetivo: int
var llamadaID: int
# Dragger de la clavija
@onready var Dragger: Node2D = $visual

func _ready() -> void:
	Global.connect("endedCall",_endedCall)
	self.add_to_group("clavijas")
	reset()

# --- METODOS PUBLICOS --------------------------------------------------------
func reset() -> void:
	Dragger.reset()
	objetivo = -1
	llamadaID = -1
	if bombilla != null:
		bombilla.reset()

func setCallID(callId: int) -> void:
	llamadaID = callId
	objetivo = Global.soluciones[callId]
	if bombilla != null:
		bombilla.setCall(callId)

func check(correct):
	if bombilla!= null and llamadaID != -1:
		bombilla.check(correct)

# CUANDO SUELTAS UNA CLAVIJA
func unPlug() -> void:
	if bombilla!= null:
		bombilla.unPlug()

# --- METODOS PRIVADOS --------------------------------------------------------

func _endedCall(callid:int):
	if callid == llamadaID:
		reset()
