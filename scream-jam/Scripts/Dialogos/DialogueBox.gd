extends Node

@onready var audio_stream: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var button: Button = $Button
@onready var label: Label = $Button/Label

#color de cada persona
var color1 : Color
var color2 : Color
#ruta del sonido de cada persona
var sound1 = load("res://Sounds/voces/169867__halgrimm__swoosh.wav")
var sound2 = load("res://Sounds/voces/167842__speedenza__transition-whoosh-4d.wav")

#contador para que se escriba letra a letra
var textDisplayed: float = 0
#ID del dialogo en el que estamos
var dialogueID: int = 0
#ID texto del dialogo mostrado
var dialogueTextID: int = 0

var ultimaLlamadaReprod: int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	Global.playLlamada.connect(_start_quest)
	Global.allClavijasCorrect.connect(_start_quest)
	Global.nextLevel.connect(_next_level)
	
	label.text = ""

func _process(delta: float) -> void:
	if textDisplayed < 1:
		textDisplayed+=0.01
		label.visible_ratio = textDisplayed

func _next_dialogue():
	
	#completa el texto si no lo ha hecho
	if textDisplayed >= 1:
		textDisplayed = 0
	else:
		textDisplayed = 1
		label.visible_ratio = textDisplayed
	
	# Comprueba si ha acabado el dialogo
	if dialogueTextID >= JsonData.json_data.Dialoges[dialogueID].Texts.size() :
		_end_dialogue()
		print("FIN DEL DIALOGO")
		return
	else:
		if JsonData.dialogos[dialogueID].Texts[dialogueTextID].Person == 0:
			audio_stream.stream = sound1
			label.add_theme_color_override("font_color", color1)
		else:
			audio_stream.stream = sound2
			label.add_theme_color_override("font_color", color2)
		
		audio_stream.play()
		
		if "@" in JsonData.dialogos[dialogueID].Texts[dialogueTextID].Text:
			label.text = JsonData.dialogos[dialogueID].Texts[dialogueTextID].Text.replace('@', '')
			#DEBUG: se llama a este metodo cuando se ha contrastado soluciones
			#_start_dialogue(true)
		else:
			label.text = JsonData.dialogos[dialogueID].Texts[dialogueTextID].Text
			dialogueTextID +=1
	

func _start_quest(idText: int):
	if idText == ultimaLlamadaReprod:
		return
	
	
	dialogueTextID = 0
	textDisplayed = 0
	
	#hace visible el cuadro de dialogo
	#get_tree().paused = false
	self.visible = true
	dialogueID = idText
	#ultimaLlamadaReprod = dialogueID
	
	#asigna las diferentes propiedades
	#sound1 = load(JsonData.dialogos[dialogueID].Sound1)
	#sound2 = load(JsonData.dialogos[dialogueID].Sound2)
	
	sound1 = load("res://Sounds/voces/167842__speedenza__transition-whoosh-4d.wav")
	sound2 = load("res://Sounds/voces/169867__halgrimm__swoosh.wav")
	
	color1 = Color(JsonData.dialogos[dialogueID].Color1.R,JsonData.dialogos[dialogueID].Color1.G,JsonData.dialogos[dialogueID].Color1.B, 1)
	color2 = Color(JsonData.dialogos[dialogueID].Color2.R,JsonData.dialogos[dialogueID].Color2.G,JsonData.dialogos[dialogueID].Color2.B, 1)
	
	if Global.nivelCorrecto:
		_start_dialogue()
		return
	print("START LLAMADA")
	_next_dialogue()

func _start_dialogue() -> void:
	self.visible = true
	textDisplayed = 0
	_avanzar_hasta_quest()
	_next_dialogue()

func _end_dialogue():
	ultimaLlamadaReprod = dialogueID
	self.visible = false
	Global._llamada_terminada(dialogueID)

func _avanzar_hasta_quest()->void:
	dialogueTextID = 0
	while not "@" in JsonData.dialogos[dialogueID].Texts[dialogueTextID].Text:
		dialogueTextID +=1
	dialogueTextID +=1

func _next_level()->void:
	self.visible = false
