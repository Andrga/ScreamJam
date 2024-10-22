extends Node

var llamadaID: int = -1

func _PlayLlamada():
	if not llamadaID < 0:
		print("reproduce llamada" , llamadaID)
		Global.playLlamada.emit(llamadaID)
	else:
		print("No hay llamada") 
