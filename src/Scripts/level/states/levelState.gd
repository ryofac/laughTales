extends State
class_name LevelState
@export var levelController: Level;
var player: Player;

func _ready():
	await levelController.playerCreated;
	player = levelController.player;
