extends Node2D

var enemyScenes = [preload("res://Scenes/throwerEnemy.tscn"), preload("res://Scenes/smallDemon.tscn")]
@onready var playerScene = preload("res://Scenes/player.tscn")
@onready var enemyScene = enemyScenes[1];

var player: Player;

const START_POSITION := Vector2(300, 200)
signal playerCreated();

func _ready():
	print("Sendo spawnado!")
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
	playerCreated.emit();

func instantiateEnemy(pos):
	var enemyIns = (enemyScenes.pick_random().instantiate() as Enemy)
	enemyIns.global_position = pos
	add_child(enemyIns)
	
