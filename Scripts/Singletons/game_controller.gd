extends Node
class_name GameController

signal changingLevel;

@onready var stateMachine: StateMachine = $StateMachine;
var in_game = false;
@export var can_change_fullscreen = true;
@export var debug = false;
@export var actualMenuScene: PackedScene = preload("res://Scenes/GUI/pause_menu.tscn")
@export var gameOverScene: PackedScene = preload("res://Scenes/GUI/game_over.tscn");
var levels: Array[PackedScene] = [
	preload("res://Scenes/level.tscn")
]

var currentLevel = null;
var currentLevelNode = null;

var hudScene = preload("res://Scenes/GUI/hud.tscn");
var hudNode = null;

func _input(event):
	if event.is_action_pressed("fullscreen") and can_change_fullscreen:
		if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED);
			
func changeLevel(ind: int):
	if currentLevelNode: currentLevelNode.queue_free();
	currentLevel = levels[ind]
	changingLevel.emit();
	spawnLevel(currentLevel)
	print("[ DEBUG ] - Spawnando level de índice: %d" % [ind])
	
func setMenuSceen(menuScene: PackedScene):
	actualMenuScene = menuScene
	
func spawnLevel(level: PackedScene):
	var instance = level.instantiate();
	currentLevelNode = instance;
	add_child.call_deferred(instance);

func restartLevel():
	currentLevelNode.queue_free();
	currentLevelNode = null;
	spawnLevel(currentLevel);

func drawHud():
	hudNode = hudScene.instantiate() as CanvasLayer;
	add_child.call_deferred(hudNode)
