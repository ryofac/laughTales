extends RigidBody2D
class_name Ball

@export var SPEED = 4.0;
@export var timer = 0.5;
@export var vanishingTime = 1.0;
var dir: Vector2;
var damage: float;
var thrower: Entity;


func _ready():
	pass

func _process(delta):
	var velocity = dir * SPEED;
	if timer > 0:
		var collider = move_and_collide(velocity);
		if collider:
			if !(collider.get_collider() is Enemy or Player):
				return
			if collider.get_collider() is Player: 
				damage = 1;
				collider.get_collider().audio_damage.play();
				HealthManager.decrease_life(1)
			collider.get_collider().take_damage(damage)
			dir = dir.bounce(collider.get_normal());
			timer = 0.05;
	else:
		vanishingTime -= delta;
		if vanishingTime <= 0: queue_free();
			
	timer -= delta;
