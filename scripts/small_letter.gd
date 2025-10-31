class_name Projectile extends RigidBody2D
var big_letters = ["R","C","T","V","L","K","Z"]
var small_letters = ["a", "g", "x", "q", "u", "o"]
var big = false

func _ready() -> void:
	if big:
		$Label.text = big_letters.pick_random()
		$CollisionShape2D.scale = Vector2(2,2)
		$Label.scale = Vector2(2,2)
	else:
		$Label.text = small_letters.pick_random()

func _process(delta: float) -> void:
	rotation_degrees += 5
	if get_parent().up:
		linear_velocity.y -= 100
	else:
		linear_velocity.y += 100

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
