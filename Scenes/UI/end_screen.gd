extends Control

const BG_SPEED = -10.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Bg.scroll_offset += Vector2(BG_SPEED,0.0)
	
	if Input.is_action_just_pressed("jump"):
		print_debug("hello?")
		get_tree().change_scene_to_file("res://Scenes/UI/title_screen.tscn")
