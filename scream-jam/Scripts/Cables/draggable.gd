extends Node2D

var isDraggable = false # si se puede draggear
var InDropZone = false # para saber si esta sobre una drop zone
var refDropZone # guarda referencia a la dropZone cuando el objeto esta dentro

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isDraggable:
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position()
		elif Input.is_action_just_released("click"):
			Dragging.isDragging = false
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
		InDropZone = true
		refDropZone = body
		
func _on_area_2d_body_exited(body):
	if body.is_in_group('dropZone'):
		InDropZone = false
