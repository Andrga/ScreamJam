extends Scene

func on_enable() -> void:
	var mat = $PostProcessing/CombinationShader.material
	mat.set_shader_parameter("intensity", 1)
	# SONIDO AQUI
	AudioManager.set_ambience_param("Mirada", 1)
