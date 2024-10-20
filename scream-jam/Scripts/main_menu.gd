class_name MainMenu
extends Control

signal totransition

@onready var start_button: Button = $MarginContainer/VBoxContainer/Start as Button
@onready var exit_button: Button = $MarginContainer/VBoxContainer/Exit as Button
@onready var credits_scene = preload("res://Scenes/Flujo/CreditsScene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.button_down.connect(_on_start_down)
	exit_button.button_down.connect(_on_exit_down)

func _on_start_down() -> void:
	#get_tree().change_scene_to_packed(credits_scene)
	print("TOFADE")
	emit_signal("totransition")
	#self.visible = false;
	
func _on_exit_down() -> void:
	get_tree().quit();

func _on_fade_scene_transitioned() -> void:
	self.visible = false;
	self.process_mode = Node.PROCESS_MODE_DISABLED
