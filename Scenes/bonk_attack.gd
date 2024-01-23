extends State
class_name bonkAttackS
@export var player: Player

var sprite;
var bonk_attack_texture = preload("res://Assets/Image/player/special_attack.png")

#onEnter -> infelizmente timers tem que ser atualizados aqui para não ficarem 0
@export var duraction = 0.5
var attackTime = duraction;

func enter():
	bonk()
	attackTime = duraction
	sprite = player.activeSprite as Sprite2D
	super.enter()
	

func update(delta):
	resetSpritePosition()
	sprite = player.activeSprite as Sprite2D
	if attackTime > 0:
		attackTime -= delta;
	else:
		Transitioned.emit(self, "walking")
	if sprite.texture.resource_name != "special_attack":
			sprite.texture = bonk_attack_texture

func physics_update(delta):
	pass

func bonk():
	player.canMove = false
	# É somado com um vetor pra dar um offset do player
	var position = player.global_position + Vector2(0 , randf_range(-4, -7))
	DialogManager.spawnFloatingText("BONK", Color.DARK_RED, position)

func resetSpritePosition():
	sprite.rotation_degrees = lerp(sprite.rotation_degrees, 0.0, 0.1)

func changeTexture():
	if sprite.texture.resource_name != "special_attack":
			sprite.texture = bonk_attack_texture
	
		
