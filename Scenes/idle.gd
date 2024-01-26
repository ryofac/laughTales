extends EnemyState
class_name enemyIdleS

var idleTime: float;

func enter():
	enemy.being_attacked.connect(_on_enemy_being_attacked);
	enemy.canMove = false
	idleTime = 2
	
func update(delta):
	var distance = player.global_position - enemy.global_position
	enemy.sprite.play("idle")
	
	if enemy.is_dying:
		enemy.sprite.stop();
	
	if distance.length() < 50 and distance.normalized().dot(enemy.direction) > 0:
		Transitioned.emit(self, "following");
	if idleTime > 0:
		idleTime -= delta;
	else:
		Transitioned.emit(self, "wandering")

func _on_enemy_being_attacked():
	Transitioned.emit(self, "attacked");
