extends Node2D

var height : int = 4
var weight : int = 5

# clavijeros
var off_cr_x = 723; # offset clavijeros
var off_cr_y = 246; # aka posicion incial del primer clavijero
var sep_cr_x = 115; # separacion entre clavijeros
var sep_cr_y = 97; # separacion entre clavijeros
# clavijas
var off_cs_x = 722; # offset clavijas
var off_cs_y = 258; # aka posicion incial de la primera clavija
var sep_cs_x = 78; # separacion entre clavijas
# bombillas
var off_b_x = 565;
var off_b_y = 220; 
var sep_b_y = 90;

var gridClavijeros = []
var bombillas = []

#fin de juego
var noMasLlamadas: bool = false

# tiempo de espera para tener un nuevo nivel
var maxTime:float = 1
var elapsedTime: float = 0
var newlevel: bool = false

func _ready() -> void:
	Global.nextLevel.connect(_onCheck)
	#var ambient = SceneManager.ambient_sound
	#ambient.stream = load("res://Sounds/ambiente.mp3")
	#ambient.play()
	#ambient.set_bus_volume_db
	
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
		bombilla.cableID = i
		bombillas.append(bombilla)
		$Bombillas.add_child(bombilla)
		#print(DisplayServer.window_get_size().y)
		bombilla.position = Vector2(1918 - off_b_x, i * sep_b_y + off_b_y)
	
	for i in weight: #clavijas
		var clavija = load("res://Scenes/Cables/Draggable.tscn").instantiate()
		$CheckClavijas.grid.append(clavija)
		$"Clavija y clavijero".add_child($CheckClavijas.grid[i])
		clavija.refBombilla = bombillas[i].get_node("Sprite2D")
		var pos = Vector2(i*sep_cs_x + off_cs_x, 1078 - off_cs_y) 
		var pos_abajo = Vector2(pos.x + 3, pos.y + 90)
		clavija.origin.global_position = pos_abajo;
		$CheckClavijas.grid[i].initialPos = pos
		$CheckClavijas.grid[i].position = pos
		
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
		$CheckClavijas.grid[i].clavijaState = Global.ClavijasState.APAGADA
	
	# vamos por el nivel 1, tenemos 1 llamada
	
	#establece las llamadas y sus clavijeros
	for i in Global.niveles[Global.nivel]:
		if Global.llamadaActual >= JsonData.json_data.Dialoges.size()-1:
			noMasLlamadas= true
			print("Se acabo el juego")
		gridClavijeros[JsonData.json_data.Dialoges[Global.llamadaActual].Clavijero].DropZone = Global.llamadaActual
		$CheckClavijas.grid[i].clavijaState = Global.ClavijasState.REGU
		Global.SceneManager.sfx_2.stream = load("res://Sounds/clavijas/encendido_bombilla.wav")
		Global.SceneManager.sfx_2.play()
		$CheckClavijas.grid[i].Clavija = Global.llamadaActual
		$CheckClavijas.grid[i].refBombilla.get_parent().llamadaID = Global.llamadaActual
		Global.llamadaActual += 1
	
	Global.nivel += 1
func _process(delta: float) -> void:
	if elapsedTime < maxTime:
		elapsedTime += delta
	elif !newlevel:
		if Global.nivel == 1:
			Global.playLlamada.emit(0)
		newlevel = true
		_new_level()

func _onCheck():
	if noMasLlamadas:
		Global._poner_los_creditos()
		return
	newlevel = false;
	elapsedTime =0
	
	for i in weight:
		$CheckClavijas.grid[i].Clavija = -2;
		$CheckClavijas.grid[i].refBombilla.get_parent().llamadaID =-1
		$CheckClavijas.grid[i].clavijaState = Global.ClavijasState.APAGADA
	pass
