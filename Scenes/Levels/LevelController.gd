extends Node2D

# Make autoload to load player stats ( for multiple levels )
@export var player: Node2D
@export var nextLevel: String

@onready var start = get_node("Start")
@onready var finish = get_node("Finish")


# Called when the node enters the scene tree for the first time.
func _ready():
	start_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func start_level():
	player = PlayerStats.get_player()
	add_child(player)
	player.hit.connect(_on_player_hit)
	
	player.camera.limit_left = $CameraLimits/TopLeft.position.x
	player.camera.limit_right = $CameraLimits/DownRight.position.x
	player.camera.limit_top = $CameraLimits/TopLeft.position.y
	player.camera.limit_bottom = $CameraLimits/DownRight.position.y
	
	player.position = start.position
	finish.body_entered.connect(_on_finish_entered)


func _on_finish_entered(body: Node2D):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(nextLevel)


func _on_player_hit(healthLeft):
	$HUD.set_hearts(healthLeft)


func _on_death_plane_body_entered(body):
	if body.is_in_group("player"):
		body.game_over()
	else:
		body.queue_free()
