extends CanvasLayer

signal transitioned

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#transition()
	pass


func transition():
	$AnimationPlayer.play("fade_in")
	Global.SceneManager.sfx.stream = load("res://Sounds/fade/683096__florianreichelt__woosh.mp3")
	Global.SceneManager.sfx.play()
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		Global.transitioned.emit()
		$AnimationPlayer.play("fade_out")
	#elif anim_name == "fade_out":
		#print("FUERA FADE")
		
