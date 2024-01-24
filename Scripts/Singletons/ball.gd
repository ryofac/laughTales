extends RigidBody2D

@export var SPEED = 4.0;
@export var timer = 0.5;
var dir: Vector2;


func _ready():
	pass

func _process(delta):
	if timer > 0:
		var velocity = dir * SPEED;
		#global_position += velocity; 
		var collider = move_and_collide(velocity);
		
		if collider:
			dir = dir.bounce(collider.get_normal());
			timer = 0.05;

	timer -= delta;
