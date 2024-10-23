extends Node2D

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
var off_b_x = 600;
var off_b_y = 190; 
var sep_b_y = 80;

var gridClavijeros = []
var bombillas = []

#fin de juego
var noMasLlamadas: bool = false

# tiempo de espera para tener un nuevo nivel
var maxTime:float = .1
var elapsedTime: float =0
var newlevel: bool = false

func _ready() -> void:
	Global.nextLevel.connect(_onCheck)
	
	# Posicionamiento 
	var w = 0
	var h = 0
	
	for i in height * weight: #clavijeros
		var clavijero = load("res://Scenes/Cables/DropZone.tscn").instantiate()
		gridClavijeros.append(clavijero)
		$"Clavija y clavijero".add_child(gridClavijeros[i])
		
		if w == weight:
			h += 1
			w = 0
		
		gridClavijeros[i].position = Vector2(w * sep_cr_x + off_cr_x, h * sep_cr_y + off_cr_y) 
		w += 1
	
	for i in weight: # bombillas
		var bombilla = load("res://Prefabs/Bombilla.tscn").instantiate()
		bombillas.append(bombilla)
		$Bombillas.add_child(bombilla)
		bombilla.position = Vector2(DisplayServer.window_get_size().x - off_b_x, i * sep_b_y + off_b_y)
	
	for i in weight: #clavijas
		var clavija = load("res://Scenes/Cables/Draggable.tscn").instantiate()
		$CheckClavijas.grid.append(clavija)
		$"Clavija y clavijero".add_child($CheckClavijas.grid[i])
		clavija.refBombilla = bombillas[i].get_node("Sprite2D")
		$CheckClavijas.grid[i].initialPos = Vector2(i*sep_cs_x + off_cs_x, DisplayServer.window_get_size().y - off_cs_y) 
		$CheckClavijas.grid[i].position = Vector2(i*sep_cs_x + off_cs_x, DisplayServer.window_get_size().y - off_cs_y) 
		

		
	# Asignacion de valores
	for i in height * weight:
		gridClavijeros[i].DropZone = Global.grid[i]
	for i in weight:
		$CheckClavijas.grid[i].Clavija = i + 1;
	Global.cables = $CheckClavijas.grid

func _new_level():
	#asigna los numeros 0 a los clavijeros
	for i in height * weight:
		gridClavijeros[i].DropZone = -1
	for i in weight:
		$CheckClavijas.grid[i].Clavija = -2;
		$CheckClavijas.grid[i].refBombilla.get_parent().llamadaID =-1
		$CheckClavijas.grid[i].refBombilla.texture = $CheckClavijas.grid[i].BombillaApagada;
	
	# vamos por el nivel 1, tenemos 1 llamada
	Global.nivel += 1
	
	#establece las llamadas y sus clavijeros
	for i in Global.nivel:
		if Global.llamadaActual >= JsonData.json_data.Dialoges.size()-1:
			noMasLlamadas= true
			print("Se acabo el juego")
		gridClavijeros[JsonData.json_data.Dialoges[Global.llamadaActual].Clavijero].DropZone = Global.llamadaActual
		$CheckClavijas.grid[i].refBombilla.texture = $CheckClavijas.grid[i].BombillaRegu
		$CheckClavijas.grid[i].Clavija = Global.llamadaActual
		$CheckClavijas.grid[i].refBombilla.get_parent().llamadaID = Global.llamadaActual
		Global.llamadaActual += 1
	
func _process(delta: float) -> void:
	if elapsedTime < maxTime:
		elapsedTime += delta
	elif !newlevel:
		newlevel = true
		_new_level()

func _onCheck():
	if noMasLlamadas:
		Global._poner_los_creditos()
		return
	newlevel = false;
	elapsedTime =0
	pass
