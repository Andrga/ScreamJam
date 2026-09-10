extends Node
class_name ClavijasManager

@export var weight : int = 5
@export var separacion:int = 100

var _clavijas = []
const CLAVIJA = preload("uid://bgoopn5ii5cak")

func _ready() -> void:
	pass

func start():
	for i in weight: #clavijas
		_clavijas.append(CLAVIJA.instantiate())
		self.add_child(_clavijas[i])
		
		_clavijas[i].position = Vector2(i * separacion, 0) 
	reset()

func reset():
	# Reseteo de clavijas.
	for c in _clavijas:
		c.reset()

func setCallID():
	# SE HA TERMINADO EL JUEGO
	if Global.nivel >= len(Global.niveles): return
	var i = 0 #para sacar el numero de narrativa
	# Contador de narrativas.
	print("NIVEL ACTUAL" + str(Global.nivel))
	for j in Global.nivel:
		if j < 0: break
		i +=  Global.niveles[j]
	# Asignacion de objetivos.
	for j in Global.niveles[Global.nivel]:
		_clavijas[j].setCallID(i)
		i += 1

func setBombillas(bombillas = []):
	for i in bombillas.size():
		_clavijas[i].bombilla = bombillas[i]
		_clavijas[i].bombilla.setCall(_clavijas[i].llamadaID)
		#print("LLAMADA ASIGNADA A BOMBILLA "+str(i) +"/"+ str(_clavijas[i].llamadaID))

func find_closest_enchufe(point: Vector2, max_distance: float = INF) -> Node2D:
	var ref_point: Vector2 = point
	var max_sq := max_distance * max_distance
	var best: Node = null
	var best_sq := INF
	
	# Recorre todos los nodos en el grupo "dropZone"
	for dz in get_tree().get_nodes_in_group("dropZone"):
		# Si el enchufe ya tiene clavija (propiedad _clavija) lo saltamos.
		# get(prop, default) devuelve default si la propiedad no existe.
		if dz.get("_clavija") != null:
			continue
		# Se utiliza el cuadrado porque es mas eficiente.
		# Distancia al cuadrado entre el punto de referencia y el enchufe.
		var d_sq : float = (dz.global_position - ref_point).length_squared()
		# Ignorar si esta fuera del maximo permitido.
		if max_distance != INF and d_sq > max_sq:
			continue
			
		# Mantener el mas cercano.
		if d_sq < best_sq:
			best_sq = d_sq
			best = dz
	
	return best
