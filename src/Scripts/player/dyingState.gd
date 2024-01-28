extends State

@export var player: Player;
var oneShot = false;


func enter():
	pass;

func update(delta):
	player.velocity = Vector2.ZERO;
	if !oneShot: 
		player.died.emit();
		oneShot = true;
	
func physics_update(delta):
	pass
