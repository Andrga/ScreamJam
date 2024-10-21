extends Node

signal totransition
signal transitioned
#senial que se manda cuando es conectada una clavija: TRUE es correcto || FALSE incorrecto
signal clavijaConected(correct)

enum Scenes { MAIN_MENU, CLAVIJAS, MESA, PUERTA, CREDITS, NULL }

var to_scene: Scenes = 0;
var current_scene : Scenes = 0

# para saber si se esta draggeando algo o no
var isDragging = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
