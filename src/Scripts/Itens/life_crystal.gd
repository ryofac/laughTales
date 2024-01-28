extends Node2D

@export var HEALING_FACTOR: int = 1;

var used: bool = false;
@onready var stream = $AudioStreamPlayer2D as AudioStreamPlayer2D

func _ready():
	pass

func _on_body_entered(body):
	if body is Player:
		stream.play();
		if !used:
			body.healing(HEALING_FACTOR);
			visible = false;
			await stream.finished
			queue_free();
