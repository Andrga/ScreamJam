extends Area2D

@export var to_scene : PackedScene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.input_pickable = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	Global.current_scene = Global.Scenes.CLAVIJAS
	Global.to_scene = Global.Scenes.PUERTA
	Global.totransition.emit()
	
