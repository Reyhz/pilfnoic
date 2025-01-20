extends CharacterBody2D

const SPEED = 80
const PLAYER_JUMP = -350
var direction = -1
var death = false
var coinloss = 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	coinloss = randi_range(2,5)


func _physics_process(delta):
	velocity.y += gravity * delta
	
	if not $RayCast2D.is_colliding() or $RayCastFront.is_colliding():
		direction = -direction
		$RayCast2D.position.x *= -1
		$RayCastFront.position.x *= -1
		$RayCastFront.scale.x *= -1
		$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
	
	velocity.x = SPEED * direction if not death else 0
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i).get_collider()
		if collision.is_in_group("player") && collision.has_method("damage"):
			collision.damage()


func coinfight():
	if PlayerStats.coinflip():
		killed()
		PlayerStats.coins += coinloss
		$Label.text = "HEADS !"
	else:
		PlayerStats.coins -= coinloss
		$Label.text = "TAILS !"
	$Label.show()


func killed():
	death = true
	$AnimatedSprite2D.play("death")
	await $AnimatedSprite2D.animation_finished
	queue_free()


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		coinfight()
		body.velocity.y = PLAYER_JUMP
