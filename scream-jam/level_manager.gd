extends Node2D

var nivel : int = 0
var height : int = 4
var weight : int = 6

var gridClavijeros = []

func _ready() -> void:
	var w = 0
	var h = 0
	
	for i in height * weight:
		gridClavijeros.append(load("res://Scenes/Cables/DropZone.tscn").instantiate())
		$"Clavija y clavijero".add_child(gridClavijeros[i])
		
		if w == weight:
			h += 1
			w = 0
		
		gridClavijeros[i].position = Vector2(w * 400 + 300, h * 150 + 250) 
		w += 1
	
	for i in 6:
		print("crea Hijo")
		$CheckClavijas.grid.append(load("res://Scenes/Cables/Draggable.tscn").instantiate())
		$"Clavija y clavijero".add_child($CheckClavijas.grid[i])
		
		$CheckClavijas.grid[i].initialPos = Vector2(i*150 + 500, DisplayServer.screen_get_size().y -100) 
		$CheckClavijas.grid[i].position = Vector2(i*150 + 500, DisplayServer.screen_get_size().y -100) 
	

func _new_level():
	
	for i in 6:
		if i <= nivel:
			$CheckClavijas.grid[i].Clavija = i
	
	nivel += 1
	
	
	pass
