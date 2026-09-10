extends Node2D

var isDraggable = true
var clicked = false 			# Para saber si esta arrastrandose.
var _dropzone = null 	# Dropzones overlapeadas.

@onready var cable: Line2D = $"../Line2D"
@onready var origin: Node2D = $"../Origin"
@onready var clavijaVis: Node2D = $ButtonContainer
@onready var button: Button = $ButtonContainer/Button
@onready var cable_point: Node2D = $CablePoint

const CLAVIJA_INSER = preload("uid://6saxmlaafvtu")
const CLAVIJA_SUELTA = preload("uid://djiuuiilhi5j6")


## Distancia maxima a considerar un enchufe para attachar
const MAX_ATTACH_DISTANCE := 60
## Desfase visual para cuadrar clavija con en movimiento
var MOVEMENT_CLAVIJA_OFFSET := Vector2(0, 55)

# --- BASE ------------------------------------------------
# Called when the node enters the scene tree for the first time.
func _process(_delta: float) -> void:
	if clicked:
		# posicion y rotacion de la clavija
		global_position = get_global_mouse_position()
		look_at_with_pivot(origin.global_position, get_global_mouse_position(), 90)
	# Linea de cable
	# obtener posicion global del cable_point y convertirla al espacio local de cable
		var gp := cable_point.global_position
		cable.points[0] = cable.to_local(gp)
	else:
		# si no esta clickeado, usar la posician actual del nodo (global -> local de cable)
		cable.points[0] = cable.to_local(global_position)
	# el extremo del cable apuntando al origin (tambien convertido al espacio local de cable)
	cable.points[1] = cable.to_local(origin.global_position)


# --- METODOS PUBLICOS ------------------------------------------------

## Resetea posicion y enchufe objetivo
func reset():
	# tween de posicion
	clavijaVis.position = Vector2.ZERO
	var tweenPos = get_tree().create_tween() # crea tween en la jerarquia
	tweenPos.tween_property(self, "global_position", origin.global_position - MOVEMENT_CLAVIJA_OFFSET, 0.2).set_ease(Tween.EASE_OUT)
	# tween de rotacion
	var tweenRot = get_tree().create_tween() # crea tween en la jerarquia
	tweenRot.tween_property(self, "rotation_degrees", 0, 0.2).set_ease(Tween.EASE_OUT)
	# cambia el icono
	button.icon = CLAVIJA_SUELTA
	# Resetea la posicion del cable
	# si no esta clickeado, usar la posician actual del nodo (global -> local de cable)
	cable.points[0] = cable.to_local(global_position)
	# el extremo del cable apuntando al origin (tambien convertido al espacio local de cable)
	cable.points[1] = cable.to_local(origin.global_position)

# --- METODOS PRIVADOS ------------------------------------------------

## Comprueba que hacer con el dropzone cuando sueltas una clavija.
func _checkDropZone() -> void:
	# Busca una dropzone valida en la lista (la primera libre)
	#var dz = _findObjetiveEnchufe()
	var dz = null
	if ($"../../".name == "ClavijasManager"):
		dz = $"../..".find_closest_enchufe(global_position, MAX_ATTACH_DISTANCE)
	if dz == null:
		# si ninguna valida -> reset
		reset()
		return
	# Insertamos la clavija en el enchufe.
	_dropzone = dz
	_dropzone.insertar(get_parent())
	#SONIDO AQUI
	AudioManager.play_sfx("event:/SFX/PonerClavija")
	global_position = dz.global_position
	button.icon = CLAVIJA_INSER
	clavijaVis.position = Vector2(0,0)
	# SONIDO AQUI

## Hace que el nodo mire al objetivo target_global pero rotando alrededor de pivot_global.
## offset_degrees sirve para compensar el frente del sprite (p. ej. la clavija esta rotada (0,90).
func look_at_with_pivot(pivot_global: Vector2, target_global: Vector2, offset_degrees: float = 0.0) -> void:
	# Vector desde pivot al objetivo y al nodo.
	var to_target := target_global - pivot_global
	var to_self := self.global_position - pivot_global
	# Angulos (radianes)
	var angle_target := to_target.angle()
	var angle_self := to_self.angle()
	
	# Diferencia de angulo que hay que rotar (radianes).
	var angle_diff := wrapf(angle_target - angle_self, -PI, PI)
	# Rotamos alrededor del pivot la diferencia.
	rotate_around_pivot_global(origin.global_position, rad_to_deg(angle_diff))
	# Rotacion.
	global_rotation = angle_target + deg_to_rad(offset_degrees)

## Rota el nodo alrededor de un punto global pivot_global por angle (grados).
func rotate_around_pivot_global(pivot_global: Vector2, angle: float) -> void:
	# Pasamos a radianes.
	var angle_rad = deg_to_rad(angle)
	# Calcula nueva posicion rotando el vector desde pivot hasta la posicion global actual.
	var rel := global_position - pivot_global
	rel = rel.rotated(angle_rad)
	global_position = pivot_global + rel
	# Ajusta la rotacion global del nodo.
	global_rotation += angle_rad

# --- CONEXIONES ------------------------------------------------
## PRIVATE
func _on_area_2d_mouse_entered():
	if not Global.isDragging: # si no se esta draggeando nada
		isDraggable = true 		# se puede draggear
		scale = Vector2(1.05, 1.05) # feedback
## PRIVATE
func _on_area_2d_mouse_exited():
	if not Global.isDragging: # si no se esta draggeando nada
		isDraggable = false 	# resetea isDraggable
		scale = Vector2(1, 1) # feedback
## PRIVATE
func _on_button_button_down() -> void:
	# SONIDO AQUI
	AudioManager.play_sfx("event:/SFX/CogerClavija")
	# Coger una clavija
	button.icon = CLAVIJA_SUELTA
	clicked = true
	clavijaVis.position = MOVEMENT_CLAVIJA_OFFSET
	# Si ya estabas en una dropzone, limpiar:
	if _dropzone != null and _dropzone._clavija == get_parent():
		_dropzone._clavija = null
		get_parent().unPlug()
## PRIVATE
func _on_button_button_up() -> void:
	clicked = false
	_checkDropZone()
