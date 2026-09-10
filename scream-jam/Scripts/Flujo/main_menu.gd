extends Scene
class_name MainMenu

@onready var start_button: Button = $Start as Button
@onready var exit_button: Button = $VBoxContainer/Exit as Button
@onready var v_box_container: VBoxContainer = $VBoxContainer/VBoxContainer
@onready var exit: TextureButton = $VBoxContainer/Exit
@onready var labelLenguajes: Label = $VBoxContainer/Lenguages/Label
@onready var labelExit: Label = $VBoxContainer/Exit/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	JsonParser._load_lenguage("res://Jsons/spanish.json")

func _on_start_down() -> void:
	Global.totransition.emit(Global.Scenes.CONTEXT)
	# SONIDO AQUI
	AudioManager.play_sfx("event:/SFX/CascosTransicion")


func _on_exit_down() -> void:
	# SONIDO AQUI
	AudioManager.play_sfx("event:/SFX/Boton")
	get_tree().quit()
	pass

func _show_lenguages()-> void:
	# SONIDO AQUI
	AudioManager.play_sfx("event:/SFX/Boton")
	v_box_container.visible = not v_box_container.visible 
	labelLenguajes.text = JsonParser.json_data.UI.Lenguage
	labelExit.text = JsonParser.json_data.UI.Exit
	exit.visible = not exit.visible

func _set_ingles()->void:
	# SONIDO AQUI
	AudioManager.play_sfx("event:/SFX/Boton")
	JsonParser._load_lenguage("res://Jsons/englis.json")
	_show_lenguages()

func _set_espaniol()->void:
	# SONIDO AQUI
	AudioManager.play_sfx("event:/SFX/Boton")
	JsonParser._load_lenguage("res://Jsons/spanish.json")
	_show_lenguages()

func _on_start_button_down() -> void:
	# SONIDO AQUI
	AudioManager.play_sfx("event:/SFX/Cascos")
	Global.totransition.emit(Global.Scenes.CLAVIJAS)

func _on_exit_button_down() -> void:
	get_tree().quit()

func on_enable() -> void:
	# SONIDO AQUI
	AudioManager.play_ambience("event:/Juego")
	AudioManager.set_ambience_param("Mirada", 3)
