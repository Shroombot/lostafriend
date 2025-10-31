extends Node
var host = false
var shooter = false

func _process(_delta: float) -> void:
	host = multiplayer.is_server()
