extends Scene

var elapsedTime: float = 0
var maxTime: float = 4
var aumentado: bool = false
@onready var control: Control = $Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if elapsedTime<= maxTime:
		control.scale =  Vector2((1+elapsedTime)/10,(1+elapsedTime)/10)
		elapsedTime += delta
	elif not aumentado:
		_to_main_menu()

func _input(_event):
	if Input.is_action_just_pressed("Skip"):
		_to_main_menu()

func _to_main_menu():
	elapsedTime = maxTime
	Global.totransition.emit(Global.Scenes.MAIN_MENU)
	aumentado = true
