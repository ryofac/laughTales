extends Node
class_name GameController

@onready var stateMachine: StateMachine = $StateMachine;
var in_game = false;
@export var can_change_fullscreen = true;
@export var debug = false;
var levels: Array[PackedScene] = [
	preload("res://Scenes/level.tscn")
]
var currentLevel = null;

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS;
	stateMachine.process_mode = Node.PROCESS_MODE_ALWAYS;

func _input(event):
	if event.is_action_pressed("fullscreen") and can_change_fullscreen:
		if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED);
			
func changeLevel(ind: int):
	currentLevel = levels[ind]
	spawnLevel(currentLevel)
	print("[ DEBUG ] - Spawnando level de índice: %d" % [ind])

func spawnLevel(level: PackedScene):
	var instance = level.instantiate();
	add_child.call_deferred(instance);
