extends CanvasLayer

signal transitioned

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#transition()
	pass


func transition():
	$AnimationPlayer.play("fade_in")
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		print("DENTRO FADE")
		emit_signal("transitioned")
		$AnimationPlayer.play("fade_out")
	elif anim_name == "fade_out":
		print("FUERA FADE")
		
