extends State
@export var player: Player

func _ready():
	player.dialog_finished.connect(toMove)

func enter():
	player.canMove = false;

func update(delta):
	pass;
	
func toMove():
	Transitioned.emit(self, "walking")
