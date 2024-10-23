extends TextEdit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is VScrollBar:
			remove_child(child)
		elif child is HScrollBar:
			remove_child(child)  


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
