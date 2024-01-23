extends Entity
class_name Player
	
#var enemy: Enemy

@onready var activeSprite = $ActiveSprite 
var bonk_area_efect = preload("res://Scenes/bonk_area_efect.tscn")
var bonk_stream = [
	preload("res://Assets/Audio/clown-horn.mp3")
]

@onready var audio_player = $Bonk as AudioStreamPlayer2D;

var canMove = true

func _ready():
	pass

func _process(delta):
	direction.x = Input.get_axis("ui_left", "ui_right");
	direction.y = Input.get_axis("ui_up", "ui_down");
	direction = direction.normalized();
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
