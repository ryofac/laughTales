extends gameState

var menuNode: Node;

func _ready():
	gameController.changingLevel.connect(_on_changing_level)

func enter():
	super.enter();
	gameController.hudNode.visible = false;
	createMenu();
	get_tree().paused = true;
	
func update(delta):
	if Input.is_action_just_pressed("pause_game"):
		print("despausando")
		deleteMenu();
		Transitioned.emit(self, "normal_game");

func createMenu():
	var _ins = gameController.actualMenuScene.instantiate();
	menuNode = _ins;
	gameController.add_child(_ins)

func _on_changing_level():
	deleteMenu();
	Transitioned.emit(self, "normal_game")
	
func deleteMenu():
	if menuNode:
		print(menuNode)
		menuNode.queue_free();
