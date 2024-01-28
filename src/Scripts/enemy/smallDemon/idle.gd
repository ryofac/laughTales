extends EnemyState
class_name enemyIdleS

var idleTime: float;

func _ready():
	enemy.being_attacked.connect(_on_enemy_being_attacked);
	

func enter():
	enemy.velocity = Vector2.ZERO;
	idleTime = 2
	
func update(delta):
	var distance = player.global_position - enemy.global_position
	enemy.sprite.play("idle")
	
	if enemy.is_dying:
		enemy.sprite.stop();
		return;
	
	if distance.length() < 50 and distance.normalized().dot(enemy.direction) > 0:
		Transitioned.emit(self, "attacking");
	if idleTime > 0:
		idleTime -= delta;
	else:
		Transitioned.emit(self, "wandering")

func _on_enemy_being_attacked():
	if !enemy.is_dying: Transitioned.emit(self, "attacked");