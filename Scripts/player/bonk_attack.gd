extends State
class_name bonkAttackS
@export var player: Player

var sprite;
var delay = 1.5;
#var bonk_attack_texture = preload("res://Assets/Image/player/special_attack.png")

#onEnter -> infelizmente timers tem que ser atualizados aqui para não ficarem 0
@export var duraction = 0.5
var attackTime = duraction;
var attacked = false;

func enter():
	bonk()
	attacked = false;
	attackTime = duraction
	
	super.enter()
	

func update(delta):
	sprite = player.sprite as AnimatedSprite2D
	resetSpritePosition()
	if attackTime > 0:
		attackTime -= delta;
	else:
		Transitioned.emit(self, "walking")
		
	#Ativa a animação uma vez só
	if sprite.animation != "bonk":
		sprite.play("bonk");

func physics_update(delta):
	if !attacked:
		for enemy in player.enemiesInRange:
			enemy.take_damage(player.BONK_DAMAGE_AMOUNT);
		attacked = true;

func bonk():
	player.canMove = false
	# É somado com um vetor pra dar um offset do player
	var position = player.global_position + Vector2(0 , randf_range(-4, -7))
	DialogManager.spawnFloatingText("BONK", Color.DARK_RED, position)
	player.spawnBonkArea() 
	player.remainingJoy -= player.joySpent;
	HealthManager.update_joy(player.remainingJoy);

func resetSpritePosition():
	sprite.rotation_degrees = move_toward(sprite.rotation_degrees, 0.0, 0.1)



#func changeTexture():
	#if sprite.texture.resource_name != "special_attack":
			#sprite.texture = bonk_attack_texture
