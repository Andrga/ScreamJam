extends Node

# SEÑALES
signal totransition
signal transitioned
signal levelChanged(level)
#senial que se manda cuando es conectada una clavija: TRUE es correcto || FALSE incorrecto
signal clavijaConected(correct, index) #index es el indice de la clavija conectada
signal nextLevel # senial para avanzar el nivel
signal playLlamada(index) # senial para avanzar el nivel
signal allClavijasCorrect 

# FLUJO
enum Scenes { MAIN_MENU, CLAVIJAS, MESA, PUERTA, CREDITS, NULL }
var to_scene : Scenes = 0
var current_scene : Scenes = 0

# LOGICA
#grid ejemplo 0
var grid := [ 0, 0, 0, 0, 1,  
			  2, 0, 0, 0, 0,
			  3, 0, 0, 0, 5,
			  0, 0, 4, 0, 0]
var correctos := [false, false, false, false, false]
var cables = []

# para saber si se esta draggeando algo o no
var isDragging = false

# nivel actual
var nivel: int = 0
var llamadaActual: int = 0 # llamada por la que va

var nPostits = 0;

# METODOS
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var llamadasReprodEnEsteNivel: int = 0
#funcion para cuando termina una llamada suma uno al contador de llamadas y decide cuando generar el siguiente caso
func _llamada_terminada()->void:
	llamadasReprodEnEsteNivel +=1
	if llamadasReprodEnEsteNivel >= nivel:
		nextLevel.emit()
		llamadasReprodEnEsteNivel = 0

func _poner_los_creditos()->void:
	current_scene = Scenes.CLAVIJAS
	to_scene = Scenes.CREDITS
	totransition.emit()
