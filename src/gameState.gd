extends State;
class_name gameState
@export var gameController: GameController;
var player: Player
var enemies: Array[Node];

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS;
