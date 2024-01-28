extends Entity
class_name Enemy
signal player_on_attack_area();
signal died();

@onready var sprite = $AnimatedSprite2D as AnimatedSprite2D;
@onready var life_bar = $TextureProgressBar as TextureProgressBar;
@export var navAgent : NavigationAgent2D;
@export var PLAYER_DAMAGE = 1;

#Preciso da referencia do player, mas ela aparece só nos estados
@onready var player = get_tree().get_first_node_in_group("player") as Player
@onready var attackRange = get_node("AttackRange") as Area2D;
@onready var levelController = get_tree().get_first_node_in_group("levelController")

@onready var audio_death = $Audio/Death as AudioStreamPlayer2D;
@onready var audio_damage = $Audio/TakingDamage as AudioStreamPlayer2D;

#Itens
var life_crystal = preload("res://Scenes/life_crystal.tscn");
var joy_crystal = preload("res://Scenes/joy_crystal.tscn");

var playerAttacked: Player;

var spawnPosition: Vector2

var on_target: bool = false;

## Pra quando estiver morrendo
var deathTimer = 1.0;

# Animação da mira
var counter = 0;
@export var crosshSpeed = 3
@export var animationRange = 3;
@export var COOLDOWN_ATTACK_TIME = 0.5;
var oneShot = true;


func _ready():
	spawnPosition = global_position
	remainingLife = maxLife
	life_bar.max_value = maxLife;
	navAgent.path_desired_distance = 4;
	navAgent.target_desired_distance = 4;
	died.connect(levelController._on_enemy_died)

func _physics_process(delta):
	move_and_slide();
	
func _process(delta):
	counter += 1
	if counter > 360: counter = 0
	
	crosshair_animation();
	manageSprite();
	checkPlayerInAttackRange();
	life_bar.value = lerp(life_bar.value, remainingLife, 0.168);
	
	if is_dying:
		if oneShot:
			died.emit();
			oneShot = false;
		death_animation(delta);
	
func manageSprite():
	if !weakref(player): return
	if !player: return
	$Crosshair.visible = player.target == self;
	
	life_bar.value = remainingLife;
	
	if !velocity.is_zero_approx():
		sprite.play("run")
		sprite.flip_h = velocity.normalized().x < 0
	else:
		if sprite.animation != "hit":
			sprite.play("idle")
		
func crosshair_animation():
	var _newPosition = Vector2(
		sin(deg_to_rad(counter * crosshSpeed)) * animationRange,
		cos(deg_to_rad(counter * crosshSpeed)) * animationRange
	)
	$Crosshair.position = _newPosition;
		
func death_animation(delta: float):
	deathTimer -= delta;
	if deathTimer > 0:
		sprite.position.x = sin(deg_to_rad( counter * 75));
	else:
		spawnItem(global_position);
		queue_free();
		
func checkPlayerInAttackRange():
	var bodies = attackRange.get_overlapping_bodies();
	if player in bodies:
		player_on_attack_area.emit();

func _input(event):
	#if event.is_action_pressed("tome"):
		#take_damage();
	pass

func spawnItem(pos: Vector2):
	var randN = randi_range(1, 5);
	
	if randN > 2:
		return;
	
	var _item;
	randN = randi_range(1, 5);
	
	print_rich("[color=pink] " + str(randN))
	
	if randN > 3:
		_item = life_crystal.instantiate() as Node2D;
	else:
		_item = joy_crystal.instantiate() as Node2D;
	
	get_parent().add_child(_item);
	_item.global_position = global_position;