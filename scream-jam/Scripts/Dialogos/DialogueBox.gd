extends Node

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var label: Label = $Label

#contador para que se escriba letra a letra
var textDisplayed: float = 0
#ID del dialogo en el que estamos
var dialogueID: int = 0
#ID texto del dialogo mostrado
var dialogueTextID: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
		return
	
	
	if dialogueTextID >= JsonData.dialogos[dialogueID].Texts.size() :
		print("FIN DEL DIALOGO")
	else:
		label.text = JsonData.dialogos[dialogueID].Texts[dialogueTextID].Text
		dialogueTextID +=1

func _end_dialogue():
	pass