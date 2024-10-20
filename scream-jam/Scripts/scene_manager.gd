extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_main_menu_totransition() -> void:
	$FadeScene.transition()


func _on_fade_scene_transitioned() -> void:
	$Credits.visible = true;
	$Credits.process_mode = Node.PROCESS_MODE_INHERIT
