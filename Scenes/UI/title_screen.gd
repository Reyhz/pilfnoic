extends Control

const BG_SPEED = -10.0

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Bg.scroll_offset = Vector2(BG_SPEED,0.0)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Bg.scroll_offset += Vector2(BG_SPEED,0.0)
	
	if Input.is_action_just_pressed("jump"):
		get_tree().change_scene_to_file("res://Scenes/Levels/main.tscn")
	
	if Input.is_action_just_pressed("escape"):
		get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)


func _on_timer_timeout():
	$StartText.visible = not $StartText.visible
