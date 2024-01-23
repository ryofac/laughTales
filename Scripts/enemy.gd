extends Entity
class_name Enemy

@onready var sprite = $AnimatedSprite2D as AnimatedSprite2D;

func _physics_process(delta):
	velocity = speed * direction * int(canMove)
	move_and_slide();
	
func _process(delta):
	manageSprite();
	
func manageSprite():
	if !velocity.is_zero_approx():
		sprite.play("run")
		sprite.flip_h = direction.x < 0
	else:
		sprite.play("idle")
