extends Scene

var postitsTraducidos: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func on_enable() -> void:
	# SONIDO AQUI
	AudioManager.set_ambience_param("Mirada", 2)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if JsonParser.json_data != null and not postitsTraducidos:
		postitsTraducidos = true
		$PostitiTutoPapel/Label.text = JsonParser.json_data.UI.Papers
		$PostitiTutoBasura/Label.text = JsonParser.json_data.UI.Discarts
		$PostitiTutoMapa/Label.text = JsonParser.json_data.UI.Map
		$PostitiTutoCalle/Label.text = JsonParser.json_data.UI.Clue
		$PostitiTutoCalle2/Label.text = JsonParser.json_data.UI.Clue2
