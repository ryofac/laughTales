extends Entity
class_name Player
	
#var enemy: Enemy
signal died();
signal dialog_finished();

@onready var audio_bonk = $Audio/Bonk as AudioStreamPlayer2D;
@onready var audio_throwing = $Audio/Throwing as AudioStreamPlayer2D;
@onready var audio_damage = $Audio/TakingDamage as AudioStreamPlayer2D;
@onready var sprite = $animSprite as AnimatedSprite2D;

var attackingEnemy = null;
#variável que serve de controle para os inimigos atacarem
var under_attack = false;

var bonk_area_efect = preload("res://Scenes/bonk_area_efect.tscn")
var bonk_stream = [
	preload("res://Assets/Audio/Player/Horn/clown-horn.mp3"),
	preload("res://Assets/Audio/Player/Horn/clown-horn_1.mp3"),
	preload("res://Assets/Audio/Player/Horn/clown-horn_2.mp3"),
	preload("res://Assets/Audio/Player/Horn/bicycle-horn.mp3"),
	preload("res://Assets/Audio/Player/Horn/bicycle-horn_1.mp3"),
	preload("res://Assets/Audio/Player/Horn/baby-squeak-toy.mp3"),
	preload("res://Assets/Audio/Player/Horn/squeaky-toy.mp3")
]

@export var MAX_JOY = 100;
@export var joySpent = 25;
var remainingJoy;

var enemiesInRange = [];
var target: Enemy;
var targetIndex = 0;
var canBeAttacked = true;
@export var BONK_DAMAGE_AMOUNT: float;
@export var NORMAL_ATTACK_AMOUNT: float;
@export var THROWING_ATTACK_AMOUNT: float;

func _ready():
	sprite.play("idle");
	# Isso está presente na entidade para o controle das frases que ele fala quando
	#toma dano
	damagePhrases = ["Its not a joke!", "This is not fun!", "That hurt! :/"]
	colorDamage = Color.RED
	
	maxLife = 5;
	remainingLife = maxLife;
	HealthManager.set_initial_life(maxLife);
	
	remainingJoy = MAX_JOY;
	

func _process(delta):
	direction.x = Input.get_axis("ui_left", "ui_right");
	direction.y = Input.get_axis("ui_up", "ui_down");
	direction = direction.normalized();
	
	# Toca idle apenas se tiver parado e não estiver atacando
	if !direction and canMove:
		if sprite.animation != "hit": sprite.play("idle");
		sprite.rotation_degrees = lerp(sprite.rotation_degrees, 0.0, 0.1);
	getEnemies();
	defineTarget();
	velocity = speed * direction * int(canMove)
	move_and_slide()

# Por enquanto essa função tá aqui por teste, ela é pra ser uma função dentro
# de um estado separado

func talk():
	var text: Array[String] = ["Abobra com mel"]
	DialogManager.startDialogue(global_position, text)

#func _unhandled_input(event):
	#if event.is_action_pressed("ui_home"):
		##talk()
		#if remainingLife < maxLife:
			#HealthManager.increase_life(1);
		
		
func spawnBonkArea():
	var _b = bonk_area_efect.instantiate();
	add_child(_b);
	_b.global_position = global_position;
	play_bonk();
	
# preciso que o target seja atualizado sempre, independente do estado atual;
func getEnemies():
	var range_area = $rangeArea as Area2D;
	# pega todos os corpos em contato e filtra apenas os inimigos
	if range_area.has_overlapping_bodies():
		enemiesInRange = range_area.get_overlapping_bodies().filter(func(x): return x is Enemy and !x.is_dying) as Array[Enemy];
		enemiesInRange.sort_custom(func(a, b): return self.global_position.distance_to(a.global_position) < self.global_position.distance_to(b.global_position))
	else:
		enemiesInRange = []

func defineTarget():
	if enemiesInRange.is_empty():
		target = null;
		return;

	if !target or target not in enemiesInRange:
		targetIndex = 0;
		target = enemiesInRange[targetIndex];
		return
	
	if Input.is_action_just_pressed("change_target"):
		targetIndex += 1
		targetIndex = targetIndex % enemiesInRange.size()
		target = enemiesInRange[targetIndex];
	
func _on_range_area_body_exited(body):
	if body is Enemy:
		body.on_target = false;
	
		
func play_bonk():
	# define qual som
	#TODO: Adicionar mais sons?
	audio_bonk.stream = bonk_stream.pick_random();
	# variação para o som
	audio_bonk.pitch_scale = randf_range(0.9, 1.1);
	audio_bonk.play()
	
func healing(value: int):
	if remainingLife < 5:
		remainingLife += value
		HealthManager.increase_life(value);

func regaining_joy(value: int):
	remainingJoy += value;
	
	if remainingJoy > MAX_JOY:
		remainingJoy = 100;
	
	HealthManager.update_joy(remainingJoy)
