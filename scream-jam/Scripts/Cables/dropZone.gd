extends StaticBody2D

var DropZone: int = 0
var solved = false
var ocupada = false
var clavija: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color(Color.CHARTREUSE, 0.5) # color y transparencia de dropzone

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
