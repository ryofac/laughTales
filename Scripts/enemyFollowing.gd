extends EnemyState
class_name enemyFollowingS
# O tempo que dura a perseguição
var followingTimer: float;

# Esse objeto directions consegue guardar os valores respectivos par os pesos em
# cada direção possíveis, indexadas em uma lista

var interestArray = [];
var dangerArray = [];

var directionsArray = [];

# O quanto os raios são projetados!
@export var seeAmount = 100;

# Número de direções ( eixos ) que o inimigo pode seguir
@export var numRays = 8;
@export var steerForce = 0.1;

# O que deve ser feito:
# Coletar dados: descobrir um meio de coletar esses dados de cada um desses vetores
# Usar detectores: descobrir uma forma de conseguir detectar as colisões das paredes
# Adcionar o Comportamento Steering
	# Achar direções que eu quero -> array desejado
	# achar direções que eu NÃO quero -> array indesejado


# Tempo que ele permanece parado antes da perseguição
var alertTimer: float;

func enter():
	enemy.being_attacked.connect(_on_enemy_being_attacked);
	
	enemy.canMove = true
	# Populando os arrays de interesse e perigo, além do de valores
	interestArray.resize(numRays);
	dangerArray.resize(numRays);
	directionsArray.resize(numRays);
	
	# Agora vem uma parte importante! a de distribuição dos eixos ao longo do inimigo:
	for i in numRays:
		var angle = i * 2 * PI / numRays;
		# Primeiro pega a base com o RIGHT e depois roda em relação ao ângulo
		directionsArray[i] = Vector2.RIGHT.rotated(angle)
	
	followingTimer = 10
	alertTimer = 1;

func update(delta):
	
	if enemy.is_dying:
		Transitioned.emit(self, "idle");
		
	if alertTimer <= 0:
		if followingTimer > 0:
			followingTimer -= delta
		else:
			followingTimer = 10
			Transitioned.emit(self, "idle")
			
	alertTimer -= delta;
	

# Vai seguir o player de acordo seu vetor direção
func physics_update(delta):
	
	# populando os arrays de interesse, perigo e escolhendo a direção que o inimigo deve ir
	setInterest();
	setDanger();
	chooseDirection();
		
	enemy.velocity = enemy.speed * enemy.direction
	
	#enemy.alert_popup.visible = alertTimer > 0;

func setInterest():
	if player:
		var desiredDirection = (player.global_position - enemy.global_position).normalized();
		for i in numRays:
			var dir = directionsArray[i].rotated(enemy.rotation).dot(desiredDirection);
			interestArray[i] = max(0, dir)

func setDanger():
	# interssectar raycasts para indentificar onde há colisões ( paredes )
	var spaceState = enemy.get_world_2d().direct_space_state;
	for i in numRays:
		var result = spaceState.intersect_ray(
			PhysicsRayQueryParameters2D.create(enemy.position, enemy.position + directionsArray[i].rotated(enemy.rotation) * seeAmount))
		dangerArray[i] = 1 if result else 0;

func chooseDirection():
	for i in numRays:
		if dangerArray[i] > 0:
			interestArray[i] = 0;
	var dir = Vector2.ZERO;
	for i in numRays:
		dir += interestArray[i] * directionsArray[i];
	enemy.direction = dir.normalized();
	
	
func _on_enemy_being_attacked():
	Transitioned.emit(self, "attacked");
