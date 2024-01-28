extends LevelState

@onready var gameController = get_tree().get_first_node_in_group("gameController")
var enemies
var lines: Array[String] = ["Congratulations, you managed to ILLUMINATE the village with your light...",
"... and jokes"]
func enter():
	enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.queue_free();
	DialogManager.startDialogue(player.global_position - Vector2(0, -10), lines)
	DialogManager.finished_text_showing.connect(_on_finished_text_showing)
	player.canMove = false;

func update(delta):
	pass
	
func _on_finished_text_showing():
	gameController.finishedGame.emit();
