extends CanvasLayer

var paused = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$CoinSprite/CoinAmount.text = "%03d" % PlayerStats.coins


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CoinSprite/CoinAmount.text = "%03d" % PlayerStats.coins
	
	if paused:
		if Input.is_action_just_pressed("escape"):
			get_tree().paused = false
			get_tree().change_scene_to_file("res://Scenes/UI/title_screen.tscn")
		if Input.is_action_just_pressed("jump"):
			get_tree().paused = false
			paused = false
			$Pause.hide()
	
	if Input.is_action_just_pressed("escape") && not paused:
		get_tree().paused = true
		paused = true
		$Pause.show()
		await get_tree().create_timer(0.1).timeout


# I hate this shit but I guess it works for now we don't need more
func set_hearts(health):
	if health <= 2:
		$HeartSprite/Full3.hide()
	if health <= 1:
		$HeartSprite/Full2.hide()
