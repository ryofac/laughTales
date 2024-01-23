extends CharacterBody2D

# Encapsula a lógica para as entidades do jogo ( que precisam andar, e afins )
class_name Entity

@export var speed: float
var direction;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
