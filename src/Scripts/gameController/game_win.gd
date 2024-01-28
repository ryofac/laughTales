extends gameState

var winNode;
var timeToContinue = 2;

func enter():
	timeToContinue = 2;
	get_tree().paused = true;
	gameController.hudNode.visible = false;
	instantiateWinScene();
	
func update(delta):
	timeToContinue -= delta;
	if Input.is_action_just_pressed("throw_attack") and timeToContinue <= 0:
		gameController.hudNode.queue_free();
		gameController.hudNode = null;
		winNode.queue_free();
		gameController.restartLevel();
		Transitioned.emit(self, "normal_game")
	

func instantiateWinScene():
	winNode = gameController.winScene.instantiate();
	gameController.add_child(winNode)
