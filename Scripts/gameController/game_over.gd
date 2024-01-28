extends gameState

var overNode;
var timeToContinue = 2;

func enter():
	get_tree().paused = true;
	gameController.hudNode.visible = false;
	instantiateGameOver();
	
func update(delta):
	timeToContinue -= delta;
	if Input.is_action_just_pressed("throw_attack") and timeToContinue <= 0:
		gameController.hudNode.queue_free();
		gameController.hudNode = null;
		overNode.queue_free();
		gameController.restartLevel();
		Transitioned.emit(self, "normal_game")
	

func instantiateGameOver():
	overNode = gameController.gameOverScene.instantiate();
	gameController.add_child(overNode)
	


