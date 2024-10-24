class_name MainMenu
extends Control

@onready var start_button: Button = $Start as Button
@onready var exit_button: Button = $VBoxContainer/Exit as Button
@onready var v_box_container: VBoxContainer = $VBoxContainer/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#start_button.button_down.connect(_on_start_down)
	#exit_button.button_down.connect(_on_exit_down)

func _on_start_down() -> void:
	Global.current_scene = Global.Scenes.MAIN_MENU
	Global.to_scene = Global.Scenes.CONTEXT
	Global.totransition.emit()
	Global.SceneManager.sfx.stream = load("res://Sounds/cascos/422651__trullilulli__sfx-player-action-phone-pick-up.wav")
	Global.SceneManager.sfx.play()
	$VBoxContainer/Lenguages/Label.text = Global.botonLenguaje[Global.lenguaje]
	$VBoxContainer/Exit/Label.text = Global.botonSalir[Global.lenguaje]
func _on_exit_down() -> void:
	Global.SceneManager.sfx.stream = load("res://Sounds/papel/428652__jomse__postit1.wav")
	Global.SceneManager.sfx.play()
	get_tree().quit()
	pass

func _show_lenguages()-> void:
	Global.SceneManager.sfx.stream = load("res://Sounds/papel/428652__jomse__postit1.wav")
	Global.SceneManager.sfx.play()
	v_box_container.visible = not v_box_container.visible 
	$VBoxContainer/Lenguages/Label.text = Global.botonLenguaje[Global.lenguaje]
	$VBoxContainer/Exit/Label.text = Global.botonSalir[Global.lenguaje]

func _set_ingles()->void:
	Global.SceneManager.sfx.stream = load("res://Sounds/papel/428652__jomse__postit1.wav")
	Global.SceneManager.sfx.play()
	JsonData._load_lenguage("res://Jsons/englis.json")
	Global.lenguaje = 0
	_show_lenguages()

func _set_espaniol()->void:
	Global.SceneManager.sfx.stream = load("res://Sounds/papel/428652__jomse__postit1.wav")
	Global.SceneManager.sfx.play()
	JsonData._load_lenguage("res://Jsons/spanish.json")
	Global.lenguaje = 1
	_show_lenguages()


func _on_start_button_down() -> void:

	Global.current_scene = Global.Scenes.MAIN_MENU
	Global.to_scene = Global.Scenes.CLAVIJAS
	Global.totransition.emit()




func _on_exit_button_down() -> void:
	get_tree().quit()
	pass # Replace with function body.
