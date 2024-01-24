extends State

class_name throwAttackS

@export var player: Player;

@export var duraction = 0.5
var attackTime;

var ballScene = preload("res://Scenes/ball.tscn")

func enter():
	attackTime = duraction;
	throw_ball();
	
func update(delta):
	
	if attackTime > 0:
		attackTime -= delta;
	else:
		Transitioned.emit(self, "walking")
	
	# animação de arremesso
	
func physics_update(delta):
	pass

func throw_ball():
	var _b = ballScene.instantiate();
	player.get_parent().add_child(_b);
	_b.global_position = player.global_position
	_b.dir = player.global_position.direction_to(player.target.global_position);
