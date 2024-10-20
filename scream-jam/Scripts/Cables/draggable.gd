extends Node2D

var isDraggable = false # si se puede draggear
var inDropZone = false # para saber si esta sobre una drop zone
var clicked = false # para saber si esta sobre una drop zone
var refDropZone # guarda referencia a la dropZone cuando el objeto esta dentro
var offset : Vector2
var initialPos : Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if isDraggable:
		if event is InputEventMouseButton:
			#initialPos = global_position
			offset = get_global_mouse_position() - global_position
			Dragging.isDragging = true
		if clicked:
			if event is InputEventMouseMotion:
				position = (event.position - offset)
		
			
# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if clicked:
		global_position = get_global_mouse_position() - offset
	else:
		Dragging.isDragging = false
		# ---- tween
		var tween = get_tree().create_tween() # crea tween en la jerarquia
		if inDropZone:
			tween.tween_property(self, "position", refDropZone.position, 0.2).set_ease(Tween.EASE_OUT)
		else:
			tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)
		
func _ready() -> void:
	initialPos = global_position

# area
func _on_area_2d_mouse_entered():
	if not Dragging.isDragging: # si no se esta draggeando nada
		isDraggable = true 		# se puede draggear
		scale = Vector2(1.05, 1.05) # feedback

func _on_area_2d_mouse_exited():
	if not Dragging.isDragging: # si no se esta draggeando nada
		isDraggable = false 	# resetea isDraggable
		scale = Vector2(1, 1) # feedback
	
func _on_area_2d_body_entered(body:StaticBody2D):
	if body.is_in_group('dropZone'):
		inDropZone = true
		refDropZone = body
		
func _on_area_2d_body_exited(body):
	if body.is_in_group('dropZone'):
		inDropZone = false

# button
func _on_button_button_down() -> void:
	clicked = true

func _on_button_button_up() -> void:
	clicked = false
