extends State

class_name throwAttackS

@export var player: Player;

@export var duraction = 0.5
var attackTime;

var ballScene = preload("res://Scenes/ball.tscn")
var throwDirection;
var spritePlayer

func enter():
	spritePlayer = player.sprite
	player.canMove = true;
	attackTime = duraction;
	throwDirection = player.global_position.direction_to(player.target.global_position);
	throw_ball();
	
func update(delta):
	spritePlayer.rotation_degrees = lerp(spritePlayer.rotation_degrees, 0.0, 0.1);
	if attackTime > 0:
		attackTime -= delta;
	else:
		Transitioned.emit(self, "walking")
		
func animateSprite():
	player.sprite.play("walk")
	player.sprite.flip_h = throwDirection.x < 0
	spritePlayer.rotation_degrees = 45 * throwDirection.x
	
func physics_update(delta):
	pass

func throw_ball():
	var _b = ballScene.instantiate();
	player.get_parent().add_child(_b);
	_b.global_position = player.global_position
	_b.dir = throwDirection;
	_b.damage = player.THROWING_ATTACK_AMOUNT;
	animateSprite();
	
