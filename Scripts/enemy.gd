extends Entity
class_name Enemy

@onready var sprite = $AnimatedSprite2D as AnimatedSprite2D;

#Preciso da referencia do player, mas ela aparece só nos estados
@onready var player = get_tree().get_first_node_in_group("player") as Player

var on_target: bool = false;

# Animação da mira
var counter = 0;
@export var crosshSpeed = 3
@export var animationRange = 3;
##

func _physics_process(delta):
	velocity = speed * direction * int(canMove)
	move_and_slide();
	
func _process(delta):
	counter += 1
	if counter > 360: counter = 0
	crosshair_animation();
	manageSprite();
	
func manageSprite():
	$Crosshair.visible = player.target == self;
	if !velocity.is_zero_approx():
		sprite.play("run")
		sprite.flip_h = direction.x < 0
	else:
		sprite.play("idle")
		
func crosshair_animation():
	var _newPosition = Vector2(
		sin(deg_to_rad(counter * crosshSpeed)) * animationRange,
		cos(deg_to_rad(counter * crosshSpeed)) * animationRange
	)
	
	$Crosshair.position = _newPosition;
