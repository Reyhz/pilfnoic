extends Area2D

var heads = 0:
	get:
		return heads
var tails = 0:
	get:
		return tails

# Called when the node enters the scene tree for the first time.
func _ready():
	heads = randi_range(-2,4)
	tails = randi_range(1,2)


func delete():
	# Turning off collision since changing scale just after can retrigger the area entered signal
	# Giving the player twice the coin value
	$CollisionShape2D.set_deferred("disabled",true)
	
	var face = PlayerStats.coinflip()
	if face:
		PlayerStats.coins += heads
		$Label.text = "HEADS !"
	else:
		PlayerStats.coins += tails
		$Label.text = "TAILS !"
	
	$Label.show()
	
	$AnimationSprite2D.scale = Vector2(0.15, 0.15)
	$AnimationSprite2D.play("flip")
	await get_tree().create_timer(1.0).timeout
	queue_free()
