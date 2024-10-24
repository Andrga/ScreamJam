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
			print(grid[4-i].Clavija)
			if grid[4-i].Clavija >= 0:
				grid[4-i].clavijaState = Global.ClavijasState.VERDE
		else:
			if grid[4-i].Clavija >= 0:
				grid[4-i].clavijaState = Global.ClavijasState.ROJA
				Global.SceneManager.sfx_2.stream = load("res://Sounds/clavijas/Clavija_mal.wav")
				Global.SceneManager.sfx_2.play()
	
	correct = cantCorrectos == Global.niveles[Global.nivel-1]
	
	print("CORRECTO?: ", correct)
	if correct:
		Global.nivelCorrecto = true;
		#emite la señal con la clavija de mas a la derecha
		Global.allClavijasCorrect.emit(grid[0].Clavija)
		Global.IDCableActual = 0
		cantCorrectos = 0
		
	for i in grid.size():
		Global.correctos[i] = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_down() -> void:
	_check()
	Global.SceneManager.sfx.stream = load("res://Sounds/218115__mastersdisaster__switch-on-livingroom.wav")
	Global.SceneManager.sfx.play()
	pass # Replace with function body.
