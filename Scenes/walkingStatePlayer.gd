extends State

# Coloquei esse S no final para ficar claro que é um estado
class_name walkingPlayerS
@export var ANIMATION_SPEED = 5.0
@export var player: Player;

#@onready var walkingTexture = preload("res://Assets/Image/player/normal.png")

var sprite: AnimatedSprite2D;

var dir;
var rotation_angle: float

func _ready():
	player.being_attacked.connect(_on_player_being_attacked)
	
func enter():
	player.canMove = true
	

func update(delta):
	sprite = player.sprite
	#setWalkingSprite()
	dir = player.direction
	rotation_angle += 1
	if rotation_angle > 360: rotation_angle = 0
	if !player.velocity.is_zero_approx():
		animate_walk()
		sprite.play("walk");
	else:
		rotation_angle = 0
		sprite.stop()
		#if sprite:
			#Transitioned.emit(self, "idle");
			

func animate_walk():
	var sin_angle = sin(deg_to_rad(rotation_angle) * ANIMATION_SPEED) * 10
	if dir.x != 0:
		sprite.flip_h = player.direction.x < 0
	sprite.rotation_degrees = sin_angle 

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		Transitioned.emit(self, "bonk_attack");
	elif event.is_action_pressed("throw_attack"):
		if player.target:
			Transitioned.emit(self, "throwing");
#func setWalkingSprite():
	#if sprite.texture.resource_name != "normal":
		#sprite.texture = walkingTexture
		
func _on_player_being_attacked():
	if player.attackingEnemy and !player.attackingEnemy.is_dying:
		Transitioned.emit(self, "attacked")
	
		
func physics_update(delta):
	pass
