extends Node

@onready var audio_stream: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var label: RichTextLabel = $Button/RichTextLabel
@onready var button: Button = $Button

#color de cada persona
var color1 : Color
var color2 : Color
#ruta del sonido de cada persona
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
	process_mode = Node.PROCESS_MODE_PAUSABLE
	
	label.text = ""
	
	_start_quest(0)

func _process(delta: float) -> void:
	if textDisplayed < 1:
		textDisplayed+=0.1
		label.visible_ratio = textDisplayed

func _next_dialogue():
	
	#completa el texto si no lo ha hecho
	if textDisplayed >= 1:
		textDisplayed = 0
	else:
		textDisplayed = 1
		label.visible_ratio = textDisplayed
		return
	
	# Comprueba si ha acabado el dialogo
	if dialogueTextID >= JsonData.dialogos[dialogueID].Texts.size() :
		_end_dialogue()
		print("FIN DEL DIALOGO")
		return
	else:
		if JsonData.dialogos[dialogueID].Texts[dialogueTextID].Person == 0:
			audio_stream.stream = sound1
			label.push_color(color1)
		else:
			audio_stream.stream = sound2
			label.push_color(color2)
		
		audio_stream.play()
		
		if "@" in JsonData.dialogos[dialogueID].Texts[dialogueTextID].Text:
			label.text = JsonData.dialogos[dialogueID].Texts[dialogueTextID].Text.replace('@', '')
			#DEBUG: se llama a este metodo cuando se ha contrastado soluciones
			_start_dialogue(true)
		else:
			label.text = JsonData.dialogos[dialogueID].Texts[dialogueTextID].Text
			dialogueTextID +=1
	

func _start_quest(idText: int):
	
	print(idText)
	
	#hace visible el cuadro de dialogo
	#get_tree().paused = false
	label.visible = true
	button.visible = true
	dialogueID = idText
	dialogueTextID = 0
	textDisplayed = 0
	
	#asigna las diferentes propiedades
	sound1 = load(JsonData.dialogos[dialogueID].Sound1)
	sound2 = load(JsonData.dialogos[dialogueID].Sound2)
	
	color1 = Color(JsonData.dialogos[dialogueID].Color1.R,JsonData.dialogos[dialogueID].Color1.G,JsonData.dialogos[dialogueID].Color1.B, 1)
	color2 = Color(JsonData.dialogos[dialogueID].Color2.R,JsonData.dialogos[dialogueID].Color2.G,JsonData.dialogos[dialogueID].Color2.B, 1)
	_next_dialogue()

func _start_dialogue(check : bool) -> void:
	if check:
		dialogueTextID +=1
		

func _end_dialogue():
	#get_tree().paused = true
	label.visible = false
	button.visible = false
