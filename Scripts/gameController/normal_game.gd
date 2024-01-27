extends State

@export var gameController: GameController;

func enter():
	get_tree().paused = false;
	if !gameController.currentLevel:
		print("Mudando");
		gameController.changeLevel(0);
		
func update(delta):
	if Input.is_action_just_pressed("pause_game"):
		print("pausando")
		Transitioned.emit(self, "paused");
		

func physics_update(delta):
	pass
		
