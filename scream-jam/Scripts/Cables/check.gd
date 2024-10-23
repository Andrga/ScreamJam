extends Node

var grid = []
var espaciado

func _check():
	var correct : bool = true
	
	for i in grid.size():
		grid[i]._check_Clavija()
	Global.correctos.sort()
	print(Global.correctos)
	
	var cantCorrectos = 0
	
	for i in grid.size():
		if Global.correctos[i]:
			cantCorrectos += 1
		#print(Global.correctos[i], " ")
	
	correct = cantCorrectos == Global.niveles[Global.nivel]
	
	print("CORRECTO?: ", correct)
	if correct:
		Global.nivelCorrecto = true;
		#emite la señal con la clavija de mas a la derecha
		Global.allClavijasCorrect.emit(grid[0].Clavija)
		cantCorrectos = 0
		
	for i in grid.size():
		Global.correctos[i] = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_down() -> void:
	_check()
	pass # Replace with function body.
