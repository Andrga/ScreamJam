extends Control

var elapsedTime: float = 0
var maxTime: float = 6
var textDisplay: float = 0
var aumentado: bool = false
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.totransition.connect(_cambio_idioma)

func _cambio_idioma():
	label.text = Global.contexto[Global.lenguaje]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if elapsedTime<= maxTime:
		if textDisplay < 1:
			label.visible_ratio =  textDisplay
			textDisplay += 0.005
		else:
			label.visible_ratio =  1
		elapsedTime += delta
	elif not aumentado:
		Global.current_scene = Global.Scenes.CONTEXT
		Global.to_scene = Global.Scenes.CLAVIJAS
		Global.totransition.emit()
		aumentado = true
