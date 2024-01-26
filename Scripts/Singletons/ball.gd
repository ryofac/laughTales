extends RigidBody2D

@export var SPEED = 4.0;
@export var timer = 0.5;
@export var vanishingTime = 1.0;
var dir: Vector2;
var damage: float;


func _ready():
	pass

func _process(delta):
	var velocity = dir * SPEED;
	if timer > 0:
		#global_position += velocity; 
		var collider = move_and_collide(velocity);
		
		if collider:
			if collider.get_collider() is Enemy: 
				collider.get_collider().take_damage(damage)
			dir = dir.bounce(collider.get_normal());
			timer = 0.05;
	else:
		vanishingTime -= delta;
		if vanishingTime <= 0: queue_free();
			
	timer -= delta;
