class_name MainMenu
extends Control

@onready var start_button: Button = $MarginContainer/VBoxContainer/Start as Button
@onready var exit_button: Button = $MarginContainer/VBoxContainer/Exit as Button
@onready var test_scene = preload("res://Scenes/TestScene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.button_down.connect(_on_start_down)
	exit_button.button_down.connect(_on_exit_down)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func _on_start_down() -> void:
	get_tree().change_scene_to_packed(test_scene)
	
func _on_exit_down() -> void:
	get_tree().quit();
