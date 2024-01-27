extends State

class_name playerAttackedS

var timeToStop = 0.5;
var timer;
var enemy;
var played = false
var count = 0; 

var knockback_dir;
@export var player: Player

func enter():
	print("tomando dano!")
	knockback_dir = Vector2.ZERO
	timer = timeToStop;
	played = false;
	count += 1
	
func update(delta):
	var attackingEnemy = player.attackingEnemy;
	if attackingEnemy:
		knockback_dir = (player.global_position - attackingEnemy.global_position).normalized();
	if timer > 0:
		timer -= delta
	else:
		Transitioned.emit(self, "walking");
		player.attackingEnemy = null;
	if player.sprite.animation != "hit" and !played: 
		print("playando animação")
		print("===================== %d" % count)
		player.sprite.play("hit")
		played = true;
	
func physics_update(delta):
	if knockback_dir.x != 0:
		player.sprite.flip_h = knockback_dir.x > 0
	player.direction = Vector2.ZERO;
	player.global_position += 1 * knockback_dir;
	player.velocity = player.speed * player.direction

