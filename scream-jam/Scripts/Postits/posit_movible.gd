extends Node2D
class_name Posit

@onready var label: Label = $Label
@onready var text_edit: TextEdit = $TextEdit

var _mouse_pos: Vector2
var _pressed: bool = false
var to_delete: bool = false

const MAX_CHARS: int = 12

var _prev_text: String = ""
var _prev_caret_line: int = 0
var _prev_caret_col: int = 0

func _process(_delta: float) -> void:
	if _pressed:
		position = _mouse_pos

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_mouse_pos = event.position
	
	elif event is InputEventKey and event.pressed:
		if event.keycode in [KEY_ENTER, KEY_KP_ENTER]:
			_apply_text()

func _apply_text() -> void:
	if text_edit.visible == false: return
	var new_text := text_edit.text.strip_edges()
	if new_text != "":
		label.text = new_text
		text_edit.hide()
		# SONIDO AQUI
		AudioManager.play_sfx("event:/SFX/Escribir")

func _on_button_button_down() -> void:
	_pressed = true
	# SONIDO AQUI
	AudioManager.play_sfx("event:/SFX/CogerPapel")

func _on_button_button_up() -> void:
	_pressed = false
	if to_delete:
		queue_free()
		# SONIDO AQUI
		AudioManager.play_sfx("event:/SFX/EliminarPapel")

func _on_TextEdit_text_changed() -> void:
	var new_text: String = text_edit.text
	if new_text.length() > MAX_CHARS:
		# Restaurar texto anterior y posiciOn del cursor.
		text_edit.text = _prev_text
		text_edit.set_caret_line(_prev_caret_line)
		text_edit.set_caret_column(_prev_caret_col)
	else:
		_prev_text = new_text
		_prev_caret_line = text_edit.get_caret_line()
		_prev_caret_col = text_edit.get_caret_column()
	# Oculta scrollbars si existen
	for child in get_children():
		if child is VScrollBar or child is HScrollBar:
			child.visible = false
