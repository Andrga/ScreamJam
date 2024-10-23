extends Node

var llamadaID: int = -1
var cableID: int = 0

func _PlayLlamada():
	if not llamadaID < 0:
		print("reproduce llamada" , llamadaID)
		Global.playLlamada.emit(llamadaID)
		Global.IDCableActual = cableID
	else:
		print("No hay llamada") 
