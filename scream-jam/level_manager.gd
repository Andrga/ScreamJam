extends Node2D

var nivel : int = 0
var height : int = 4
var weight : int = 5

# clavijeros
var off_cr_x = 723; # offset clavijeros
var off_cr_y = 246; # aka posicion incial del primer clavijero
var sep_cr_x = 115; # separacion entre clavijeros
var sep_cr_y = 97; # separacion entre clavijeros
# clavijas
var off_cs_x = 500; # offset clavijeros
var off_cs_y = 300; # aka posicion incial de la primera clavija
var sep_cs_x = 150; # separacion entre clavijas
#var sep_cs_y = 97; # separacion entre clavijas

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
		
		gridClavijeros[i].position = Vector2(w * sep_cr_x + off_cr_x, h * sep_cr_y + off_cr_y) 
		w += 1
	
	for i in 6:
		print("crea Hijo")
		$CheckClavijas.grid.append(load("res://Scenes/Cables/Draggable.tscn").instantiate())
		$"Clavija y clavijero".add_child($CheckClavijas.grid[i])
		
		$CheckClavijas.grid[i].initialPos = Vector2(i*sep_cs_x + off_cs_x, DisplayServer.screen_get_size().y - off_cs_y) 
		$CheckClavijas.grid[i].position = Vector2(i*sep_cs_x + off_cs_x, DisplayServer.screen_get_size().y - off_cs_y) 
	

func _new_level():
	
	for i in 6:
		if i <= nivel:
			$CheckClavijas.grid[i].Clavija = i
	
	nivel += 1
	
	
	pass
