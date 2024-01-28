extends Node2D

@export var joy_factor: int = 50;
@onready var stream = $AudioStreamPlayer2D as AudioStreamPlayer2D
var used: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_body_entered(body):
	if body is Player:
		stream.play();
		if !used:
			body.regaining_joy(joy_factor)
			visible = false;
			await stream.finished
			queue_free();
