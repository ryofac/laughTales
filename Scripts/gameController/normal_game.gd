extends gameState

func _ready():
	gameController.finishedGame.connect(_on_level_ended)
	
func enter():
	super.enter();
	get_tree().paused = false;
	if !gameController.currentLevel:
		gameController.changeLevel(0);
		
	if !gameController.hudNode:
		gameController.drawHud();
		return;
		
	gameController.hudNode.visible = true;
	print(player)
		
func update(delta):
	player = get_tree().get_first_node_in_group("player");
	if Input.is_action_just_pressed("pause_game"):
		print("pausando")
		Transitioned.emit(self, "paused");
	if !weakref(player): return;
	if player != null:
		if player.died.is_connected(_on_player_died): return
		print("conectado")
		player.died.connect(_on_player_died);

func physics_update(delta):
	pass

func _on_player_died():
	print("Morri.......... ")
	Transitioned.emit(self, "game_over");

func _on_level_ended():
	print("Passou de nível")
	Transitioned.emit(self, "game_win")
