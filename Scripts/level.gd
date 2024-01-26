extends Node2D

@onready var playerScene = preload("res://Scenes/player.tscn")
@onready var enemyScene = preload("res://Scenes/smallDemon.tscn")

var player: Player;

const START_POSITION := Vector2(300, 200)


# Called when the node enters the scene tree for the first time.
func _ready():
	# Por em um local global posteriormente
	randomize()
	instantiatePlayer(START_POSITION)
	instantiateEnemy(START_POSITION + Vector2(40, 20))
	instantiateEnemy(START_POSITION + Vector2(60, 20))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func instantiatePlayer(pos: Vector2):
	player = (playerScene.instantiate() as Player)
	player.global_position = pos;
	add_child(player)

func instantiateEnemy(pos):
	var enemyIns = (enemyScene.instantiate() as Enemy)
	enemyIns.global_position = pos
	add_child(enemyIns)
	
