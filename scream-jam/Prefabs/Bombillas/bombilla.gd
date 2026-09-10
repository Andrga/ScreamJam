extends Node

var llamadaID: int = -1

var _state: Global.BombillaState = Global.BombillaState.APAGADA

@onready var visual: Sprite2D = $Sprite2D

const BOMBILLA_APAGADA = preload("uid://b47ldqjmtbv0u")
const BOMBILLA_ENCENDIDA = preload("uid://bi8olk2ndemn5")
const BOMBILLA_BIEN = preload("uid://c8j1jeweyw0b7")
const BOMBILLA_MAL = preload("uid://b0n3cw0d32fxf")

# --- BASE ------------------------------------------------
func _ready() -> void:
	self.add_to_group("bombillas")
	reset()

var countdown: bool = false
var timeToStopMal: float = 2.0
var elapsedTime: float = 0.0
var _last_state: Global.BombillaState = Global.BombillaState.APAGADA

func _process(delta: float) -> void:
	if _state == Global.BombillaState.MAL:
		if not countdown:
			return
		if elapsedTime >= timeToStopMal:
			setState(_last_state)
			elapsedTime = 0.0
			countdown = false
		else:
			elapsedTime += delta

# --- METODOS PUBLICOS ------------------------------------------------
func setCall(id:int) -> void:
	llamadaID = id
	if llamadaID <0: return
	setState(Global.BombillaState.ENCENDIDA)
	# SONIDO AQUI
	AudioManager.play_sfx("event:/SFX/BombillaEnciende")
	# Si la id de la llamada es 0, empezamos el tutorial
	if id == 0:
		Global.startTutorial.emit()

func setState(state: Global.BombillaState) -> void:
	# Guardar el estado anterior si vamos a entrar en MAL.
	if state == Global.BombillaState.MAL:
		_last_state = _state   # guardamos el estado anterior antes de cambiar.
		_state = state
		elapsedTime = 0.0
		countdown = true
	else:
		# Si salimos de MAL, detener el countdown.
		if _state == Global.BombillaState.MAL:
			countdown = false
			elapsedTime = 0.0
		_state = state
		
	_setImage()

func reset() -> void:
	setState(Global.BombillaState.APAGADA)
	llamadaID = -1

func check(correcta: bool) -> void:
	if correcta:
		# SONIDO AQUI
		AudioManager.play_sfx("event:/SFX/BombillaBien")
		setState(Global.BombillaState.BIEN)
	else:
		# SONIDO AQUI
		AudioManager.play_sfx("event:/SFX/BombillaMal")
		setState(Global.BombillaState.MAL)

func unPlug() -> void:
	if llamadaID != -1:
		setState(Global.BombillaState.ENCENDIDA)
	else:
		setState(Global.BombillaState.APAGADA)

# --- METODOS PRIVADOS ------------------------------------------------
func _setImage() -> void:
	# SONIDO AQUI
	match _state:
		Global.BombillaState.ENCENDIDA:
			visual.texture = BOMBILLA_ENCENDIDA
		Global.BombillaState.APAGADA:
			visual.texture = BOMBILLA_APAGADA
		Global.BombillaState.BIEN:
			visual.texture = BOMBILLA_BIEN
		Global.BombillaState.MAL:
			visual.texture = BOMBILLA_MAL

func _PlayLlamada() -> void:
	# Si no hay llamada return
	if llamadaID == -1: return
	var clavijascene = get_parent().get_parent()
	clavijascene.play_call(llamadaID)
	# SONIDO AQUI

# --- CONEXIONES ------------------------------------------------
func _on_button_pressed() -> void:
	# Queremos ejecutar solo si el estado NO es APAGADA y NO es BIEN:
	if _state != Global.BombillaState.APAGADA and _state != Global.BombillaState.BIEN:
		pass
	_PlayLlamada()

func _on_button_mouse_entered() -> void:
	self.scale = Vector2(1.05, 1.05) # feedback

func _on_button_mouse_exited() -> void:
	self.scale = Vector2(1, 1) # feedback
