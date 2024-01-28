extends gameState

var overNode;

func enter():
	get_tree().paused = true;
	instantiateGameOver();
	
func update(delta):
	if Input.is_action_just_pressed("throw_attack"):
		gameController.hudNode.queue_free();
		gameController.hudNode = null;
		overNode.queue_free();
		gameController.restartLevel();
		Transitioned.emit(self, "normal_game")
	

func instantiateGameOver():
	overNode = gameController.gameOverScene.instantiate();
	gameController.add_child(overNode)
	


