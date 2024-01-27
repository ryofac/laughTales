extends Node2D

@onready var playerScene = preload("res://Scenes/player.tscn")
@onready var enemyScene = preload("res://Scenes/smallDemon.tscn")

var player: Player;

const START_POSITION := Vector2(300, 200)

func _ready():
	randomize()
	instantiatePlayer(START_POSITION)
	
func _process(delta):
	if Input.is_action_just_pressed("spawnEnemies"):
		for i in range(1):
			instantiateEnemy(START_POSITION + Vector2(10 + 16*i, 0))
	
func instantiatePlayer(pos: Vector2):
	player = (playerScene.instantiate() as Player)
	player.global_position = pos;
	add_child(player)

func instantiateEnemy(pos):
	var enemyIns = (enemyScene.instantiate() as Enemy)
	enemyIns.global_position = pos
	add_child(enemyIns)
	
