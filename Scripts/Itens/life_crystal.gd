extends Node2D

@export var HEALING_FACTOR: int = 1;

var used: bool = false;

func _ready():
	pass

func _on_body_entered(body):
	if body is Player:
		if !used:
			body.healing(HEALING_FACTOR);
			queue_free();
