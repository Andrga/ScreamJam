extends Node

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var label: RichTextLabel = $RichTextLabel
@onready var audio_stream: AudioStreamPlayer2D = $AudioStreamPlayer2D

var color1 : Color
var color2 : Color

var sound1
var sound2 

#contador para que se escriba letra a letra
var textDisplayed: float = 0
#ID del dialogo en el que estamos
var dialogueID: int = 0
#ID texto del dialogo mostrado
var dialogueTextID: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	Global.clavijaConected.connect(_start_dialogue)
	
	label.text = ""

func _process(delta: float) -> void:
	if textDisplayed < 1:
		textDisplayed+=0.1
		label.visible_ratio = textDisplayed

func _next_dialogue():
	if dialogueTextID == 0:
		sound1 = load(JsonData.dialogos[dialogueID].Sound1)
		sound2 = load(JsonData.dialogos[dialogueID].Sound2)
	
	#completa el texto si no lo ha hecho
	if textDisplayed >= 1:
		textDisplayed = 0
	else:
		textDisplayed = 1
		label.visible_ratio = textDisplayed
		return
	
	
	if dialogueTextID >= JsonData.dialogos[dialogueID].Texts.size() :
		print("FIN DEL DIALOGO")
	else:
		if JsonData.dialogos[dialogueID].Texts[dialogueTextID].Person == 0:
			audio_stream.stream = sound1
		else:
			audio_stream.stream = sound2
		audio_stream.play()
		
		if "@" in JsonData.dialogos[dialogueID].Texts[dialogueTextID].Text:
			label.text = JsonData.dialogos[dialogueID].Texts[dialogueTextID].Text.replace('@', '')
			#DEBUG: se llama a este metodo cuando se ha contrastado soluciones
			_start_dialogue(true)
		else:
			label.text = JsonData.dialogos[dialogueID].Texts[dialogueTextID].Text
			dialogueTextID +=1

func _start_dialogue(check : bool) -> void:
	if check:
		dialogueTextID +=1
		

func _end_dialogue():
	pass
