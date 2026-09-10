extends Node
class_name Narrative

var narrativeBlqs: Array[NarrativeBLock]
var actualblock: int = -1
var label : Label
var emitter = null

func _init() -> void:
	pass

## Aniade un dialogo 
func add_block(NarrtBlq:NarrativeBLock = null) ->bool:
	if not NarrtBlq:
		return false
	narrativeBlqs.append(NarrtBlq)
	return true

func get_actual_block_ID() -> int:
	return actualblock
	
func get_actual_block() -> NarrativeBLock:
	return narrativeBlqs[actualblock]

func get_block(id:int) -> NarrativeBLock:
	return narrativeBlqs[id]

func get_last_block() -> NarrativeBLock:
	return narrativeBlqs[len(narrativeBlqs)-1]

func get_first_block() -> NarrativeBLock:
	return narrativeBlqs[0]

## Avanza 1 bloque
## [code]return[code] (String) el bloque siguiente
func advance_block(lbl: Label) -> void:
	# Asignacion de label.
	if lbl and label != lbl:
		label = lbl
	if label == null: return
	
	# Si no ha llegado al final y puede continuar avanza el bloque
	if not is_end() and narrativeBlqs[actualblock].can_continue():
		actualblock += 1
	if actualblock >= len(narrativeBlqs): actualblock = len(narrativeBlqs)-1
	print("SIGUIENTE BLOQUE: ", actualblock)
	var block = narrativeBlqs[actualblock]
	# Si no hay dialogo devuelve vacio
	if block == null:
		printerr("[NARRATIVE ERROR] No hay dialogo valido.")
		return 
	
	reproduce(block)

## Retrocede 1 bloque
## [code]return[code] (String) el bloque anterior
func retreat_block() -> void:
	var block = narrativeBlqs[actualblock]
	# Si no hay bloque devuelve vacio
	if block == null:
		printerr("[NARRATIVE ERROR] No hay dialogo valido.")
		return 
	# Si no ha llegado al principio y puede continuar retrocede el bloque
	if actualblock > 0 and block.can_continue():
		actualblock -= 1
	
	reproduce(block)

## Reestablece la narrativa desde el principio
func restart_block_begin() -> void:
	actualblock = 1
	var block = narrativeBlqs[actualblock]
	# Si no hay bloque devuelve vacio
	if block == null:
		printerr("[NARRATIVE ERROR] No hay bloque narrativo valido.")
		return
	
	reproduce(block)

## Reestablece la narrativa desde el final
func restart_block_end() -> void:
	actualblock = len(narrativeBlqs) - 2
	var block = narrativeBlqs[actualblock]
	# Si no hay bloque devuelve vacio
	if block == null:
		printerr("[NARRATIVE ERROR] No hay bloque narrativo valido.")
		return
	
	reproduce(block)

func reproduce(block):
	block.configure_label(label)
	label.text = block.reproduce()

func is_end() -> bool:
	return actualblock >= len(narrativeBlqs)-1

func is_begining() -> bool:
	return actualblock <= 0
