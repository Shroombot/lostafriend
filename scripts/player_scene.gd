extends CharacterBody2D
enum modes_o_move {LEFT_RIGHT, UP_DOWN, ALL, PLATFORMER}
var movement_mode = modes_o_move.LEFT_RIGHT
var speed = 400
var lock_move = false
@export var health = 5
var attack_time = 0
var attacking = false
var projectile_scene = preload("res://scenes/projectile.tscn")
var up = false

func _enter_tree():
	set_multiplayer_authority(name.to_int())
	if multiplayer.is_server():
		up = true
		$display.text = " a\nspa\nce ship\nin the sky"
		global_position = Vector2(960,1000)
	else:
		$display.text = "sky the in\nship ce\nspa\na "
		global_position = Vector2(960,345)
 
func _physics_process(_delta):
	if is_multiplayer_authority():
		if health < 1:
			print("p1 win")
		if not lock_move:
			if movement_mode == modes_o_move.ALL:
				velocity = Input.get_vector("left","right","up","down") * speed
			elif movement_mode == modes_o_move.LEFT_RIGHT:
				velocity.x = Input.get_axis("left","right") * speed
			elif movement_mode == modes_o_move.UP_DOWN:
				velocity.y = Input.get_axis("left","right") * speed
		if attacking:
			attack_time += 1
			if attack_time > 50 and not lock_move:
				velocity = Vector2.ZERO
				lock_move = true
			#scale.x += 0.01
			#scale.y += 0.01
		
		if Input.is_action_just_pressed("attack"):
			attacking = true
		
		if Input.is_action_just_released("attack"):
			lock_move = false
			attacking = false
			#var tween = create_tween().set_trans(Tween.TRANS_QUAD)
			#tween.tween_property(self,"scale",Vector2(1,1),0.1)
			if attack_time > 50:
				var projectile: Projectile = projectile_scene.instantiate()
				projectile.big = true
				projectile.global_position = global_position
				add_child(projectile)
			elif attack_time > 20:
				var projectile = projectile_scene.instantiate()
				projectile.global_position = global_position
				add_child(projectile)
			attack_time = 0
	
	move_and_slide()
 
func set_ship():
	visible = true
	movement_mode = modes_o_move.LEFT_RIGHT
	if is_multiplayer_authority():
		$display.text = " a\nspa\nce ship\nin the sky"
		global_position = Vector2(960,1000)
		
	
	else:
		$display.text = "sky the in\nship ce\nspa\na "
		global_position = Vector2(960,270)
	

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Projectile and body.get_parent() != self:
		body.queue_free()
		if body.big:
			health -= 2
		else:
			health -= 1
