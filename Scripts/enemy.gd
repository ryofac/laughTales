extends Entity
class_name Enemy

@onready var sprite = $AnimatedSprite2D as AnimatedSprite2D;

#Preciso da referencia do player, mas ela aparece só nos estados
@onready var player = get_tree().get_first_node_in_group("player") as Player

var on_target: bool = false

func _physics_process(delta):
	velocity = speed * direction * int(canMove)
	move_and_slide();
	
func _process(delta):
	manageSprite();
	
func manageSprite():
	#print(player.target)
	#print(self)
	$Crosshair.visible = player.target == self;
	
	if !velocity.is_zero_approx():
		sprite.play("run")
		sprite.flip_h = direction.x < 0
	else:
		sprite.play("idle")
