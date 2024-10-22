extends Node

var grid = []
var espaciado

func _check():
	var correct : bool = false
	
	for i in grid.size():
		grid[i]._check_Clavija()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_down() -> void:
	_check()
	pass # Replace with function body.
