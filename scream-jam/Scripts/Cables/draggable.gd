extends Node2D

var isDraggable = false # si se puede draggear
var inDropZone = false 	# para saber si esta sobre una drop zone
var clicked = false 	# para saber si esta sobre una drop zone
var snap = false 		# para saber si esta vinculada a una drop zone
var refDropZone 		# guarda referencia a la dropZone cuando el objeto esta dentro
var offset : Vector2
var initialPos : Vector2
@export var Clavija: int = 0 # al inicio se le carga un int sol != de 0 a la clavija y a la dropZone 
							 # si coinciden respuesta correcta, las dropZones que no sean solucion = 0

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
	if clicked:
		global_position = get_global_mouse_position() - offset
	else:
		Global.isDragging = false
		# ---- tween
		var tween = get_tree().create_tween() # crea tween en la jerarquia
		if inDropZone:
			tween.tween_property(self, "position", refDropZone.position, 0.2).set_ease(Tween.EASE_OUT)
		else:
			tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)

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
	if refDropZone.DropZone == Clavija:
		refDropZone.solved = true
		Global.clavijaConected.emit(true)

func _on_area_2d_body_entered(body:StaticBody2D):
	if body.is_in_group('dropZone') and not body.ocupada:
		inDropZone = true
		refDropZone = body
		body.ocupada = true
		body.clavija = self

func _on_area_2d_body_exited(body):
	if body.is_in_group('dropZone') and body.ocupada and body.clavija == self:
		inDropZone = false
		body.ocupada = false
		body.clavija = null

# button
func _on_button_button_down() -> void:
	clicked = true

func _on_button_button_up() -> void:
	clicked = false
