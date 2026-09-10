extends Node

@export var scenes: Array     # un array de nodos “Scene” preinstanciados
var actual_scene: Node = null
var to_transition: int = -1

func _ready() -> void:
	Global.SceneManager = self
	Global.totransition.connect(self._on_totransition)
	Global.transitioned.connect(self._on_fade_scene_transitioned)
	
	for child in get_children():
		if child is Scene:
			scenes.append(child)
			child.visible = false
			child.process_mode = Node.PROCESS_MODE_DISABLED
		
	# Lanzamos transicion a intro.
	Global.totransition.emit(Global.Scenes.INTRO)

func _on_totransition(scene_index: int) -> void:
	to_transition = scene_index
	$FadeScene.transition()

## Se ejecuta cuando termina la transicion (fade-out / fade-in)
func _on_fade_scene_transitioned() -> void:
	# Deshabilitar la escena actual
	if actual_scene != null:
		actual_scene.visible = false
		if "on_disable" in actual_scene:
			actual_scene.on_disable()
		actual_scene.process_mode = Node.PROCESS_MODE_DISABLED

	# Establecer la nueva escena
	if to_transition >= 0 and to_transition < scenes.size():
		actual_scene = scenes[to_transition]
	else:
		push_error("SceneManager: indice de escena invalido: %s" % to_transition)
		return

	# Habilitar la nueva escena
	actual_scene.visible = true
	actual_scene.process_mode = Node.PROCESS_MODE_INHERIT
	if "on_enable" in actual_scene:
		actual_scene.on_enable()

	# Resetear to_transition
	to_transition = -1
