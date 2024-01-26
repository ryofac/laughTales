extends Entity
class_name Enemy

signal being_attacked;

var particlesScene = preload("res://Scenes/particle.tscn");
@onready var sprite = $AnimatedSprite2D as AnimatedSprite2D;
@onready var life_bar = $TextureProgressBar as TextureProgressBar;

#Preciso da referencia do player, mas ela aparece só nos estados
@onready var player = get_tree().get_first_node_in_group("player") as Player

var on_target: bool = false;

## Pra quando estiver morrendo
var is_dying: bool = false;
var deathTimer = 1.0;

# Animação da mira
var counter = 0;
@export var crosshSpeed = 3
@export var animationRange = 3;
##

@export var maxLife: float = 50.0;
var remainingLife: float;

func _ready():
	remainingLife = maxLife
	life_bar.max_value = maxLife;

func _physics_process(delta):
	velocity = speed * direction * int(canMove)
	move_and_slide();
	
func _process(delta):
	counter += 1
	if counter > 360: counter = 0
	
	crosshair_animation();
	manageSprite();
	
	if is_dying:
		death_animation(delta);
	
func manageSprite():
	$Crosshair.visible = player.target == self;
	
	life_bar.value = remainingLife;
	
	if !velocity.is_zero_approx():
		sprite.play("run")
		sprite.flip_h = direction.x < 0
	else:
		if sprite.animation != "hit":
			sprite.play("idle")
		
func crosshair_animation():
	var _newPosition = Vector2(
		sin(deg_to_rad(counter * crosshSpeed)) * animationRange,
		cos(deg_to_rad(counter * crosshSpeed)) * animationRange
	)
	$Crosshair.position = _newPosition;

func take_damage(damage: float = 10.0):
	
	remainingLife -= damage;
	being_attacked.emit()
	
	if remainingLife <= 0:
		##dropa item
		canMove = false;
		is_dying = true;
		
		spawn_particles();
		
func death_animation(delta: float):
	deathTimer -= delta;
	
	if deathTimer > 0:
		sprite.position.x = sin(deg_to_rad( counter * 75));
		
	else:
		queue_free();

func spawn_particles():
	var _p = particlesScene.instantiate();
	get_parent().add_child(_p);
	_p.global_position = global_position;

func _input(event):
	if event.is_action_pressed("tome"):
		take_damage();
