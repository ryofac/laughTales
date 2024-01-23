extends Entity
class_name Player
	
#var enemy: Enemy

@onready var activeSprite = $ActiveSprite 

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
	var text: Array[String] = ["12345678", "UM", "TESTE!!!!"]
	DialogManager.startDialogue(global_position, text)

func _unhandled_input(event):
	if event.is_action_pressed("ui_home"):
		talk()
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
