extends Entity
class_name Player
	
#var enemy: Enemy

@onready var audio_player = $Bonk as AudioStreamPlayer2D;
@onready var anim_sprite = $animSprite as AnimatedSprite2D;

var bonk_area_efect = preload("res://Scenes/bonk_area_efect.tscn")
var bonk_stream = [
	preload("res://Assets/Audio/clown-horn.mp3"),
	preload("res://Assets/Audio/clown-horn_1.mp3"),
	preload("res://Assets/Audio/clown-horn_2.mp3"),
	preload("res://Assets/Audio/bicycle-horn.mp3"),
	preload("res://Assets/Audio/bicycle-horn_1.mp3"),
	preload("res://Assets/Audio/baby-squeak-toy.mp3"),
	preload("res://Assets/Audio/squeaky-toy.mp3")
]

var target: Enemy;

func _ready():
	anim_sprite.play("idle");


func _process(delta):
	direction.x = Input.get_axis("ui_left", "ui_right");
	direction.y = Input.get_axis("ui_up", "ui_down");
	direction = direction.normalized();
	
	# Toca idle apenas se tiver parado e não estiver atacando
	if !direction and canMove:
		anim_sprite.play("idle");
		anim_sprite.rotation_degrees = lerp(anim_sprite.rotation_degrees, 0.0, 0.1);
	
	update_target();
	
	velocity = speed * direction * int(canMove)
	move_and_slide()

# Por enquanto essa função tá aqui por teste, ela é pra ser uma função dentro
# de um estado separado

func talk():
	var text: Array[String] = ["Abobra com mel"]
	DialogManager.startDialogue(global_position, text)

func _unhandled_input(event):
	if event.is_action_pressed("ui_home"):
		talk()
		
		
func spawnBonkArea():
	var _b = bonk_area_efect.instantiate();
	add_child(_b);
	_b.global_position = global_position;
	
	play_audio();
	
# preciso que o target seja atualizado sempre, independente do estado atual;
func update_target():
	var range_area = $rangeArea as Area2D;
	
	# pega todos os corpos em contato e filtra apenas os inimigos
	if range_area.has_overlapping_bodies():
		var _enemies = range_area.get_overlapping_bodies().filter(func(x): return x is Enemy) as Array[Enemy];
		
		#só inicializa as variaveis
		var _newEnemy: Enemy = _enemies[0];
		var _shortest := global_position.distance_to(_newEnemy.global_position);
		
		for enemy in _enemies:
			var _diff = global_position.distance_to(enemy.global_position);
			
			if  _diff < _shortest:
				_newEnemy = enemy;
				_shortest = _diff;
		
		target = _newEnemy;
		
	# se não tem ninguem ent é null
	else:
		target = null;


func _on_range_area_body_exited(body):
	if body is Enemy:
		body.on_target = false;
		
func play_audio():
	# define qual som
	#TODO: Adicionar mais sons?
	audio_player.stream = bonk_stream.pick_random();
	# variação para o som
	audio_player.pitch_scale = randf_range(0.9, 1.1);
	audio_player.play()
#func tell_jokes(enemy):
	#if enemy and enemy is Enemy:
		#enemy.life_points -= 10
		#spawnLaughts(enemy.global_position)

#func spawnLaughts(pos):
	#var instance = laughtsScene.instantiate()
	#instance.global_position = pos
	#get_parent().add_child(instance)

#
#func _on_area_2d_body_entered(body):
	#if body is Enemy:
		#enemy = body

#
#func _on_area_2d_body_exited(body):
	#if body == enemy:
		#enemy = null


