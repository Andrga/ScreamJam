extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.totransition.connect(_on_totransition)
	Global.transitioned.connect(_on_fade_scene_transitioned)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_totransition() -> void: #fade in
	$FadeScene.transition()

func _on_fade_scene_transitioned() -> void: #justo antes del fadeout, la idea es que esto sea un switch
	#if Global.current_scene == Global.to_scene:
		 #pass
	match Global.current_scene:
		Global.Scenes.MAIN_MENU:
			$MainMenu.visible = false
			$MainMenu.process_mode = Node.PROCESS_MODE_DISABLED
		Global.Scenes.CLAVIJAS:
			$ClavijasScene.visible = false
			$ClavijasScene.process_mode = Node.PROCESS_MODE_DISABLED
		Global.Scenes.MESA:
			$MesaScene.visible = false
			$MesaScene.process_mode = Node.PROCESS_MODE_DISABLED
		Global.Scenes.PUERTA:
			$PuertaScene.visible = false
			$PuertaScene.process_mode = Node.PROCESS_MODE_DISABLED
		Global.Scenes.CREDITS:
			$Credits.visible = false
			$Credits.process_mode = Node.PROCESS_MODE_DISABLED
		_:
			print("hola")
	match Global.to_scene:
		Global.Scenes.MAIN_MENU:
			print("hola")
		Global.Scenes.CLAVIJAS:
			$ClavijasScene.visible = true
			$ClavijasScene.process_mode = Node.PROCESS_MODE_INHERIT
		Global.Scenes.MESA:
			$MesaScene.visible = true
			$MesaScene.process_mode = Node.PROCESS_MODE_INHERIT
		Global.Scenes.PUERTA:
			$PuertaScene.visible = true
			$PuertaScene.process_mode = Node.PROCESS_MODE_INHERIT
		Global.Scenes.CREDITS:
			$Credits.visible = true
			$Credits.process_mode = Node.PROCESS_MODE_INHERIT
		_:
			print("hola")
	Global.current_scene = Global.to_scene
