extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.totransition.connect(_on_totransition)
	Global.transition.connect(_on_fade_scene_transitioned)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_totransition() -> void: #fade in
	$FadeScene.transition()


func _on_fade_scene_transitioned() -> void: #justo antes del fadeout, la idea es que esto sea un switch
	$Credits.visible = true;
	$Credits.process_mode = Node.PROCESS_MODE_INHERIT
