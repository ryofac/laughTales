extends EnemyState

class_name enemyAttackedS

var timeToStop = 0.5;
var timer;

var knockback_dir;

func enter():
	knockback_dir = (enemy.global_position - player.global_position).normalized();
	timer = timeToStop;
	
func update(delta):
	
	knockback_dir = (enemy.global_position - player.global_position).normalized();
	
	if enemy.is_dying:
		Transitioned.emit(self, "idle");
	
	if enemy.sprite.animation != "hit": 
		enemy.sprite.play("hit")
	
	if timer > 0:
		timer -= delta
	else:
		Transitioned.emit(self, "following");


func physics_update(delta):
	if knockback_dir.x != 0:
		enemy.sprite.flip_h = knockback_dir.x > 0
	
	enemy.direction = Vector2.ZERO;
	enemy.global_position += 1 * knockback_dir;
	enemy.velocity = enemy.speed * enemy.direction * int(enemy.canMove)



