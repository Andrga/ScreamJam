extends Node

signal totransition
signal transitioned

enum Scenes { MAIN_MENU, CLAVIJAS, MESA, PUERTA, CREDITS }

var to_scene: Scenes = 0;
var current_scene : Scenes = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
