extends EnemyState
class_name enemyFollowingS
# O tempo que dura a perseguição
var fleeTimer: float;

# Esse objeto directions consegue guardar os valores respectivos par os pesos em
# cada direção possíveis, indexadas em uma lista

var interestArray = [];
var dangerArray = [];
var directionsArray = [];
var contextMap = [];

@onready var navAgent : NavigationAgent2D = enemy.navAgent;

# O quanto os raios são projetados!
@export var seeAmount = 100;

# Número de direções ( eixos ) que o inimigo pode seguir
@export var numRays = 8;
@export var maxSteerForce = 0.1;
@export var flee : bool; 
@export var roundMovementAmount: float = 0;
var desirableDir: Vector2;

# O que deve ser feito:
# Coletar dados: descobrir um meio de coletar esses dados de cada um desses vetores
# Usar detectores: descobrir uma forma de conseguir detectar as colisões das paredes
# Adcionar o Comportamento Steering
	# Achar direções que eu quero -> array desejado
	# achar direções que eu NÃO quero -> array indesejado


# Tempo que ele permanece parado antes da perseguição
var alertTimer: float;

func _ready():
	enemy.being_attacked.connect(_on_enemy_being_attacked)
	#enemy.player_on_attack_area.connect(_on_enemy_player_on_attack_area)

func enter():
	enemy.canMove = true
	# Populando os arrays de interesse e perigo, além do de valores
	interestArray.resize(numRays);
	dangerArray.resize(numRays);
	directionsArray.resize(numRays);
	contextMap.resize(numRays);
	
	# Agora vem uma parte importante! a de distribuição dos eixos ao longo do inimigo:
	for i in numRays:
		var angle = i * 2 * PI / numRays;
		# Primeiro pega a base com o RIGHT e depois roda em relação ao ângulo
		directionsArray[i] = Vector2.RIGHT.rotated(angle)
	
	fleeTimer = 3;
	alertTimer = 1;

func update(delta):
	if enemy.is_dying:
		Transitioned.emit(self, "idle");
		return;
		
	if alertTimer <= 0:
		if fleeTimer > 0:
			fleeTimer -= delta
		else:
			fleeTimer = 3
			Transitioned.emit(self, "idle")
			
	alertTimer -= delta;
	

# Vai seguir o player de acordo seu vetor direção
func physics_update(delta):
	# populando os arrays de interesse, perigo e escolhendo a direção que o inimigo deve ir
	setInterest();
	setDanger();
	chooseDirection();
	var desVel = desirableDir * enemy.speed;
	if flee: desVel = -desVel
	var steeringForce = desVel - enemy.velocity;
	steeringForce *= 1 + roundMovementAmount
	enemy.direction = desirableDir;
	enemy.velocity = enemy.velocity + (steeringForce * maxSteerForce);
	#enemy.alert_popup.visible = alertTimer > 0;

func setInterest():
	if navAgent.is_navigation_finished():
		return;
	if player:
		var desiredDirection = enemy.to_local(navAgent.get_next_path_position()).normalized();
		for i in numRays:
			var dir = directionsArray[i].rotated(enemy.rotation).dot(desiredDirection);
			interestArray[i] = dir

func setDanger():
	# interssectar raycasts para indentificar onde há colisões ( paredes )
	var spaceState = enemy.get_world_2d().direct_space_state;
	for i in numRays:
		var result = spaceState.intersect_ray(
			PhysicsRayQueryParameters2D.create(enemy.position, enemy.position + directionsArray[i].rotated(enemy.rotation) * seeAmount))
		dangerArray[i] = 5 if result else 0;

func chooseDirection():
	for i in numRays:
		contextMap[i] = interestArray[i] - dangerArray[i]
		
	var _greaterInd = contextMap[0]
	
	for i in numRays:
		if contextMap[i] >= contextMap[_greaterInd]:
			_greaterInd = i;

	desirableDir = directionsArray[_greaterInd];

func recalcPath():
	if player:
		navAgent.target_position = player.global_position
	else:
		navAgent.target_position = enemy.spawnPosition

	
func _on_enemy_being_attacked():
	if !enemy.is_dying: Transitioned.emit(self, "attacked");
	
func _on_recalc_path_timer_timeout():
	recalcPath()

#func _on_enemy_player_on_attack_area():
	#if !enemy.is_dying and !player.under_attack: 
		#Transitioned.emit(self, "attacking");


