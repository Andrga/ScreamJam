extends Node2D

var mousePos: Vector2
var pressed: bool = false
@onready var label: Label = $Label
@onready var text_edit: TextEdit = $TextEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("Postit Creado")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pressed:
		position = mousePos

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ENTER:
			_intro()
	if event is InputEventMouseMotion:
		mousePos = event.position
	if not text_edit.has_focus():
		_intro()

func _intro():
	print("intro")
	if not text_edit.text == "":
		label.text = text_edit.text
		text_edit.hide()


func _on_button_button_down() -> void:
	pressed = true

func _on_button_button_up() -> void:
	pressed = false

var currentText = ""
var LIMIT: int = 19
var cursor_line = 0
var cursor_column = 0

func _on_TextEdit_text_changed():
	var new_text : String = text_edit.text
	if new_text.length() > LIMIT:
		text_edit.text = currentText
		# when replacing the text, the cursor will get moved to the beginning of the
		# text, so move it back to where it was 
		text_edit.set_caret_line(cursor_line)
		text_edit.set_caret_column(cursor_column)

	currentText = text_edit.text
	# save current position of cursor for when we have reached the limit
	cursor_line = text_edit.get_caret_line()
	cursor_column = text_edit.get_caret_column()
