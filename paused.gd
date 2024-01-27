extends State

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func enter():
	get_tree().paused = true;
	
func update(delta):
	if Input.is_action_just_pressed("pause_game"):
		print("despausando")
		Transitioned.emit(self, "normal_game");
