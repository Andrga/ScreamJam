extends Area2D

@export var current_scene : Global.Scenes = Global.Scenes.NULL
@export var to_scene : Global.Scenes = Global.Scenes.NULL

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.input_pickable = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	$Flecha.scale = Vector2(1.2,1.2)

func _on_mouse_exited() -> void:
	$Flecha.scale = Vector2(1,1)

func _on_click() -> void:
	Global.current_scene = current_scene
	Global.to_scene = to_scene
	Global.totransition.emit()
	pass # Replace with function body.
