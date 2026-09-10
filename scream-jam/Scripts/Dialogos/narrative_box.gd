extends Control
class_name NarrativeBox

@onready var label: Label = $Button/Label

var actualNarrative := -1

#var textDisplayed: float = 0 # contador para que se escriba letra a letra
@export var chars_per_second: float = 2.0
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if label.visible_ratio < 1:
		label.visible_ratio += delta * chars_per_second

### METODOS BOTONES

func next_dialogue() -> void:
	if self.visible and Global.narrativas[actualNarrative].is_end() and label.visible_ratio == 1:
		#await get_tree().create_timer(2.0).timeout  # Espera 1 segundo
		Global.endedCall.emit(actualNarrative) # Notifica que se ha terminado la actual narrative
		actualNarrative = -1
		self.visible = false
		return
	
	if label.visible_ratio < 1 : 
		label.visible_ratio = 1
		return
	
	Global.narrativas[actualNarrative].advance_block(label)
	label.visible_ratio = 0

func _on_button_mouse_entered():
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", -0.5, 0.1)
	tween.tween_property(self, "rotation_degrees", 0, 0.1)

### METODOS CALLBACKS
func stop_input():
	Global.startTalking.emit()
	print("STOP INPUT")

func start_input():
	Global.stopTalking.emit()
	print("START INPUT")

func start_narrative_ID(id: int) ->void:
	actualNarrative = id
	label.text = ""
	next_dialogue()
	self.visible = true

func next_narrative() -> void:
	start_narrative_ID(actualNarrative + 1)
