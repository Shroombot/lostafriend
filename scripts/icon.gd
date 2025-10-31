extends TextureButton
var inside = false
@export var fake = false

func _process(_delta: float) -> void:
	$Panel.visible = inside

func _on_mouse_entered() -> void:
	if not fake:
		inside = true

func _on_mouse_exited() -> void:
	inside = false
