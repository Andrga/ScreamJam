extends Control
# Izquierda
@export var to_scene_left : Global.Scenes = Global.Scenes.NULL
# Abajo
@export var to_scene_right : Global.Scenes = Global.Scenes.NULL
# Derecha
@export var to_scene_down : Global.Scenes = Global.Scenes.NULL
# Arriba
@export var to_scene_top : Global.Scenes = Global.Scenes.NULL

const TRANSITION_AREA = preload("uid://dwjm2d85wwbrd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Arriba
	_configure_button(get_child(0), to_scene_top)
	# Derecha
	_configure_button(get_child(1), to_scene_right)
	# Abajo
	_configure_button(get_child(2), to_scene_down)
	# Izquierda
	_configure_button(get_child(3), to_scene_left)

# configura el boton
func _configure_button(TA, to_scene) -> void:
	if to_scene == Global.Scenes.NULL: 
		TA.visible  = false
		return
	TA.to_scene = to_scene
