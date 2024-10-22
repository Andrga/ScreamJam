extends Node

var mousepos: Vector2


func _intro():
	var auxPostit = load("res://Scenes/Postits/PositMovible.tscn").instantiate()
	Global.nPostits += 1
	auxPostit.name = str("PostIt", Global.nPostits)
	add_sibling(auxPostit)
	auxPostit.position = mousepos

func _input(event):
	if event is InputEventMouseMotion:
		mousepos = event.position
		#print("Mouse Motion at: ", event.position)

func _ready() -> void:
	pass
