extends Node2D

@onready var area_sprite = $areaSprite as AnimatedSprite2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	area_sprite.play("bonk");

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_sprite_animation_finished():
	queue_free();
