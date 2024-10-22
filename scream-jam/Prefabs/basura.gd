extends Node2D

var texture_normal = load("res://Images/cenicero.png")
var texture_hover = load("res://Images/cenicero_hover.png")
var mousepos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mousepos = get_global_mouse_position();


func _on_area_2d_mouse_entered() -> void:
	var buton = $TextureButton
	buton.texture_normal = texture_hover

func _on_area_2d_mouse_exited() -> void:
	var buton = $TextureButton	
	buton.texture_normal = texture_normal


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("JODEEEER")

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("JODEEEER")
