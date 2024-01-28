extends EnemyState

# Nesse estado, o inimigo fica se movendo em posições aleatórias
var timeToStop = randf_range(1, 2)

var sprite;

func _ready():
	enemy.being_attacked.connect(_on_enemy_being_attacked);

func enter():
	enemy.canMove = true
	timeToStop = randf_range(1, 2)
	randomize_movement()
	
func randomize_movement():
	enemy.direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized();
	timeToStop = randf_range(1, 2);

func update(delta):
	sprite = enemy.sprite;
	var distance = player.global_position - enemy.global_position
	
	if enemy.is_dying:
		Transitioned.emit(self, "idle");
	
	if distance.length() < 50  and distance.normalized().dot(enemy.direction) > 0:
		Transitioned.emit(self, "following");
		
	if timeToStop > 0:
		timeToStop -= delta
	else:
		Transitioned.emit(self, "idle")


func physics_update(delta):
	enemy.velocity = enemy.speed * enemy.direction;
	


func _on_enemy_being_attacked():
	Transitioned.emit(self, "attacked");
