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
var off_cs_x = 500; # offset clavijas
var off_cs_y = 300; # aka posicion incial de la primera clavija
var sep_cs_x = 150; # separacion entre clavijas
# bombillas
var off_b_y = 200; # aka posicion incial de la primera clavija

var gridClavijeros = []
var bombillas = []

func _ready() -> void:
	Global.clavijaConected.connect(_onCheck)
	
	# Posicionamiento 
	var w = 0
	var h = 0
	
	for i in height * weight:
		var clavijero = load("res://Scenes/Cables/DropZone.tscn").instantiate()
		gridClavijeros.append(clavijero)
		$"Clavija y clavijero".add_child(gridClavijeros[i])
		
		if w == weight:
			h += 1
			w = 0
		
		gridClavijeros[i].position = Vector2(w * sep_cr_x + off_cr_x, h * sep_cr_y + off_cr_y) 
		w += 1
	
	for i in weight:
		var bombilla = load("res://Prefabs/Bombilla.tscn").instantiate()
		bombillas.append(bombilla)
		$Bombillas.add_child(bombilla)
		bombilla.position = Vector2(i*sep_cs_x + off_cs_x, DisplayServer.screen_get_size().y - off_b_y)
	
	for i in weight:
		var clavija = load("res://Scenes/Cables/Draggable.tscn").instantiate()
		$CheckClavijas.grid.append(clavija)
		$"Clavija y clavijero".add_child($CheckClavijas.grid[i])
		clavija.refBombilla = bombillas[i].get_node("Sprite2D")
		$CheckClavijas.grid[i].initialPos = Vector2(i*sep_cs_x + off_cs_x, DisplayServer.screen_get_size().y - off_cs_y) 
		$CheckClavijas.grid[i].position = Vector2(i*sep_cs_x + off_cs_x, DisplayServer.screen_get_size().y - off_cs_y) 
		

		
	# Asignacion de valores
	for i in height * weight:
		gridClavijeros[i].DropZone = Global.grid[i]
	for i in weight:
		$CheckClavijas.grid[i].Clavija = i + 1;
	Global.cables = $CheckClavijas.grid

func _new_level():
	
	for i in weight:
		if i <= nivel:
			$CheckClavijas.grid[i].Clavija = i
	
	nivel += 1

func _onCheck():
	
	pass
