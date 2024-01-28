extends EnemyState

var ballScene = preload("res://Scenes/ball.tscn")
var nextDirection 
var throwDirection;
@export var timeBetweenThrows: float;
@export var timeDuringAttack: float;
var nextBallTime;
var timeAttack;
@export var fleeArea: Area2D;


func enter():
	nextBallTime = timeBetweenThrows;
	timeAttack = timeDuringAttack
	# Controla a direção pra onde o inimigo vai ficar olhando
	throwDirection = enemy.global_position.direction_to(player.global_position);
	throw_ball();

func update(delta):
	throwDirection = enemy.global_position.direction_to(player.global_position);
	enemy.direction = throwDirection
	checkEnemyInFleeArea();
	if timeAttack <= 0:
		enemy.sprite.rotation_degrees = 0;
		Transitioned.emit(self, "idle");
		return;
	if nextBallTime <= 0:
		throw_ball();
		nextBallTime = timeBetweenThrows
	else:
		nextBallTime -= delta;
	timeAttack -= delta;
	enemy.sprite.rotation_degrees = lerp(enemy.sprite.rotation_degrees, 0.0, 0.1);

func physics_update(delta):
	enemy.velocity = Vector2.ZERO;

func checkEnemyInFleeArea():
	var bodies = fleeArea.get_overlapping_bodies()
	if player in bodies:
		enemy.sprite.rotation_degrees = 0;
		Transitioned.emit(self, "flee");
		
func animateSprite():
	enemy.sprite.play("idle")
	enemy.sprite.flip_h = throwDirection.x < 0
	enemy.sprite.rotation_degrees = 45 * throwDirection.x
		
func throw_ball():
	animateSprite();
	#player.audio_throwing.play();
	#await  player.audio_throwing.finished;
	var _b = ballScene.instantiate() as Ball;
	_b.thrower = self;
	## Adequando ao player ( inimigo não vai colidir )
	
	# Adcionando em Throwable enemy e removendo de Thworable item
	_b.set_collision_layer_value(5, false)
	_b.set_collision_layer_value(6, true)
	
	# Adcionando a máscara para o player e removendo a do inimigo
	_b.set_collision_mask_value(1, true)
	_b.set_collision_mask_value(4, false)

	_b.modulate = Color.WHITE
	enemy.get_parent().add_child(_b);
	_b.global_position = enemy.global_position
	_b.dir = throwDirection;
	_b.damage = 1;
	_b.SPEED = 1
	player.attackingEnemy = enemy;
	
