extends CharacterBody2D

const SPEED = 80
var direction = -1
var death = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _physics_process(delta):
	velocity.y += gravity * delta
	
	if not $RayCast2D.is_colliding():
		direction = -direction
		$RayCast2D.position.x *= -1
		$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
	
	velocity.x = SPEED * direction if death == false else 0
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		death = true
		body.velocity.y = -250
		$AnimatedSprite2D.play("death")
		await $AnimatedSprite2D.animation_finished
		queue_free()
