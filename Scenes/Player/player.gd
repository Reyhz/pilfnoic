extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 0:
			$Animator.play("fall")
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$Animator.play("jump")
	
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			$Animator.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			$Animator.play("idle")
	
	move_and_slide()


# TODO: Show a little text if the player did head or tails to give feedback
func heads_or_tails(collectible):
	return collectible.heads if randi_range(0,1) == 0 else collectible.tails


func _on_area_2d_area_entered(area):
	if area.is_in_group("collectible"):
		match area.type:
			"coin":
				PlayerStats.coins += heads_or_tails(area)
				print_debug(PlayerStats.coins)
				area.queue_free()
