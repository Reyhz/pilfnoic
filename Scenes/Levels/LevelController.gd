extends Node2D

# Make autoload to load player stats ( for multiple levels )
@export var player: Node2D


@onready var start = get_node("Start")
@onready var finish = get_node("Finish")

# Called when the node enters the scene tree for the first time.
func _ready():
	start_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start_level():
	# TODO: Load player start from autoload script
	player = PlayerStats.get_player()
	add_child(player)
	
	player.position = start.position
	finish.body_entered.connect(_on_finish_entered)


func _on_finish_entered(body: Node2D):
	if body.is_in_group("player"):
		print_debug(body.get_name() + "has finished the level !")
