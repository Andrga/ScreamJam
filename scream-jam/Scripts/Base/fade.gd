extends CanvasLayer

func transition():
	$AnimationPlayer.play("fade_in")
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		Global.transitioned.emit()
		$AnimationPlayer.play("fade_out")
