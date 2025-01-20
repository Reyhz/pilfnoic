extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const AIR_JUMP = 0.200 # Time where the player can still jump ( in ms )

var camera = null

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var lastDir = true
var health = 3
var damaged = false
var grounded = 0

signal hit(healthLeft)

func _ready():
	camera = $Camera


func _process(delta):
	if not is_on_floor():
		grounded -= delta
	else:
		grounded = AIR_JUMP


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 0:
			$Animator.play("fall")
		else:
			$Animator.play("jump")
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or grounded > 0):
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction < 0 or (lastDir && direction == 0):
		$AnimatedSprite2D.flip_h = true
		lastDir = true
	else:
		$AnimatedSprite2D.flip_h = false
		lastDir = false
	
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			$Animator.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			$Animator.play("idle")
	
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("enemy"):
			damage()


func damage():
	if not damaged:
		health -= 1
		hit.emit(health)
		damaged = true
		set_collision_layer_value(1, false)
		set_collision_mask_value(2, false)
		blink()
		$IFrame.start()
		print_debug(health)
	if health <= 0:
		game_over()


func game_over():
	get_tree().change_scene_to_file("res://Scenes/UI/title_screen.tscn")


func blink():
	while damaged:
		$AnimatedSprite2D.visible = not $AnimatedSprite2D.visible
		await get_tree().create_timer(0.1).timeout
	if not $AnimatedSprite2D.visible:
		$AnimatedSprite2D.visible = true
	set_collision_layer_value(1, true)
	set_collision_mask_value(2, true)


func _on_area_2d_area_entered(area):
	if area.is_in_group("collectible"):
		area.delete()


func _on_i_frame_timeout():
	damaged = false
