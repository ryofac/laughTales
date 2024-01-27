extends EnemyState
class_name enemyAttackS
var canAttack: bool = true;

@export var colldownTimer: Timer;
var timeToFinish = 1;

func enter():
	print("Atacando!")
	timeToFinish = 1;
	if enemy.is_dying:
		Transitioned.emit(self, "idle")
		return;
		
	if !canAttack:
		Transitioned.emit(self, "following")
		return;
	
	enemy.velocity = Vector2.ZERO;
	enemy.sprite.rotation_degrees = 45 * enemy.direction.x;
	player.being_attacked.emit();
	player.attackingEnemy = enemy;
	player.take_damage(enemy.PLAYER_DAMAGE)
	
	HealthManager.decrease_life(player.remainingLife);
	
	canAttack = false;
	colldownTimer.start(enemy.COOLDOWN_ATTACK_TIME)

func update(delta):
	var enemyRot = enemy.sprite.rotation_degrees
	enemy.sprite.rotation_degrees = move_toward(enemyRot, 0, 1)
	if timeToFinish >= 0:
		timeToFinish -= delta;
	else:
		Transitioned.emit(self, "following")
		
	
func physics_update(delta):
	pass
	
func _on_cool_down_attack_timer_timeout():
	canAttack = true;
