extends LevelState

@onready var gameController = get_tree().get_first_node_in_group("gameController") as GameController
var enemies
var lines: Array[String] = ["Congratulations, you managed to ILLUMINATE laughTown with your light...",
"... and jokes",
"... and fun",
"... and...",
"...ok i will let you win :/"]
func enter():
	player.canMove = false;
	enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.queue_free();
	DialogManager.startDialogue(player.global_position - Vector2(0, -10), lines)
	DialogManager.finished_text_showing.connect(_on_finished_text_showing)
	gameController.hudNode.visible = false;

func update(delta):
	player.canMove = false;
	
func _on_finished_text_showing():
	gameController.finishedGame.emit();
