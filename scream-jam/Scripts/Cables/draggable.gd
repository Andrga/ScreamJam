extends Node2D

var isDraggable = false # si se puede draggear
var inDropZone = false 	# para saber si esta sobre una drop zone
var clicked = false 	# para saber si esta sobre una drop zone
var snap = false 		# para saber si esta vinculada a una drop zone
var refDropZone : StaticBody2D = null # guarda referencia a la dropZone cuando el objeto esta dentro
var offset : Vector2
var initialPos : Vector2
var Clavija: int = 0 # al inicio se le carga un int sol != de 0 a la clavija y a la dropZone 
					 # si coinciden respuesta correcta, las dropZones que no sean solucion = 0
var refBombilla : Sprite2D = null # ref a su bombilla
var BombillaApagada : Texture = load("res://Images/bombilla_apagada.png")
var BombillaVerde : Texture = load("res://Images/bombilla_verde.png")
var BombillaRegu : Texture = load("res://Images/bombilla_regu.png")
var BombillaRoja : Texture = load("res://Images/bombilla_roja.png")
var ClavijaSuelta : Texture = load("res://Images/clavija_suelta.png")
var ClavijaDentro : Texture = load("res://Images/clavija_inser.png")
@onready var Boton : Button = $"Node2D/Button"
@onready var line_2d: Line2D = $Line2D
@onready var origin: Node2D = $Origin



var clavijaState

var lastpos: Vector2
var desfaseMovimiento: Vector2 = Vector2(0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if isDraggable:
		if event is InputEventMouseButton:
			offset = get_global_mouse_position() - global_position
			Global.isDragging = true
		if clicked:
			if event is InputEventMouseMotion:
				position = (event.position - offset)

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	#if (clavijaState != Global.ClavijasState.VERDE or clavijaState != Global.ClavijasState.ROJA)and Clavija >= 0 :
	#	clavijaState = Global.ClavijasState.REGU
	
	match clavijaState:
		Global.ClavijasState.APAGADA:
			refBombilla.texture = BombillaApagada
		Global.ClavijasState.REGU:
			refBombilla.texture = BombillaRegu
		Global.ClavijasState.VERDE:
			refBombilla.texture = BombillaVerde
		Global.ClavijasState.ROJA:
			refBombilla.texture = BombillaRoja
		_:
			refBombilla.texture = BombillaApagada
	
	if clicked:
		global_position = get_global_mouse_position() - offset
		$Node2D.look_at(origin.position)
		#sprite.rotation_degrees = origin.get_angle_to(get_global_mouse_position())
		
	else:
		$Node2D.rotation_degrees = 90;
		Global.isDragging = false
		# ---- tween
		var tween = get_tree().create_tween() # crea tween en la jerarquia
		if inDropZone:
			tween.tween_property(self, "position", refDropZone.position, 0.2).set_ease(Tween.EASE_OUT)
			if Boton.icon == ClavijaSuelta:
				Global.SceneManager.sfx.stream = load("res://Sounds/clavijas/131896__bertrof__plugging-in-guitar.wav")
				Global.SceneManager.sfx.play()
				Boton.icon = ClavijaDentro
			desfaseMovimiento = Vector2(0,0)
		else:
			tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)
			if Boton.icon == ClavijaDentro:
				Boton.icon = ClavijaSuelta
			desfaseMovimiento = Vector2(0,0)
			
	if lastpos != global_position:
		line_2d.points[0] = initialPos-global_position + Vector2(0,70)
		line_2d.points[1] = desfaseMovimiento
		lastpos = global_position

func _ready() -> void:
	initialPos = position

# area
func _on_area_2d_mouse_entered():
	if not Global.isDragging: # si no se esta draggeando nada
		isDraggable = true 		# se puede draggear
		scale = Vector2(1.05, 1.05) # feedback
		

func _on_area_2d_mouse_exited():
	if not Global.isDragging: # si no se esta draggeando nada
		isDraggable = false 	# resetea isDraggable
		scale = Vector2(1, 1) # feedback

func _check_Clavija() -> void:
	# si no esta conectada sale del metodo
	if refDropZone == null:
		return
	#-------Comprobacion y señales de que sea verdad-------
	var verdad = false;
	if (refDropZone.DropZone == Clavija):
		verdad = true;
	Global.clavijaConected.emit(verdad, Clavija)	
	Global.correctos[(Global.llamadaActual - Clavija)-1] = verdad
	
	if verdad:
		clavijaState = Global.ClavijasState.VERDE
	else:
		clavijaState = Global.ClavijasState.ROJA
		
	#print("CLAVIJA ", Clavija, ": ", Global.correctos[Clavija - 1])
	#--------Bombillas--------
	# si no hay bombilla y no esta encendida sale del metodo
	#if refBombilla != null and not refBombilla.texture == BombillaRegu:
	#	return
	
	# si la clavija es correcta se pone la bombilla en su color correspondiente
	#if verdad:
	#	refBombilla.texture = BombillaVerde
	#if not verdad:
	#	refBombilla.texture = BombillaRoja


func _on_area_2d_body_entered(body:StaticBody2D):
	if body.is_in_group('dropZone') and not body.ocupada:
		inDropZone = true
		refDropZone = body
		body.ocupada = true
		body.clavija = self
		

func _on_area_2d_body_exited(body):
	if body.is_in_group('dropZone') and body.ocupada and body.clavija == self:
		if Boton.icon == ClavijaDentro:
			Global.SceneManager.sfx.stream = load("res://Sounds/clavijas/210313__soundscape_leuphana__20131209_plug-out_olympusls10_xy.wav")
			Global.SceneManager.sfx.play()
		inDropZone = false
		body.ocupada = false
		body.clavija = null
		Boton.icon = ClavijaSuelta


# button
func _on_button_button_down() -> void:
	clicked = true

func _on_button_button_up() -> void:
	clicked = false
	

func _llamada_escuchada() ->void:
	clavijaState = Global.ClavijasState.APAGADA
