extends CharacterBody2D

# Encapsula a lógica para as entidades do jogo ( que precisam andar, e afins )
class_name Entity

@export var speed: float
var direction: Vector2 = Vector2.ZERO;
