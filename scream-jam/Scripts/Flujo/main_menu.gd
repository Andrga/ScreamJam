class_name MainMenu
extends Control

@onready var start_button: Button = $MarginContainer/VBoxContainer/Start as Button
@onready var exit_button: Button = $MarginContainer/VBoxContainer/Exit as Button
@onready var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.button_down.connect(_on_start_down)
	exit_button.button_down.connect(_on_exit_down)

func _on_start_down() -> void:
	Global.current_scene = Global.Scenes.MAIN_MENU
	Global.to_scene = Global.Scenes.CLAVIJAS
	Global.totransition.emit()
	
func _on_exit_down() -> void:
	get_tree().quit()

func _show_lenguages()-> void:
	v_box_container.visible = not v_box_container.visible 

func _set_ingles()->void:
	JsonData._load_lenguage("res://Jsons/spanish.json")
	_show_lenguages()

func _set_espaniol()->void:
	JsonData._load_lenguage("res://Jsons/spanish.json")
	_show_lenguages()
