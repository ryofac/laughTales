extends LevelState;
var lines: Array[String] = ["Welcome to the laughLand!, try to press 'z' ",
"congratulations, you can read!",
"haha, sorry... with this button you can shoot JOY at enemies",
"you can use 'x' to change targets",
"...and space...",
"i will let you see",
"but be careful with your JOY BAR, it may run out",
"a bunch of dark creatures are trying to DESTROY this land...",
"use your JOY to destroy them!",
"now make them laugh!",
"your mission is to destroy at least 10 of them!",
"...and don't die"]

var continueLine = [
[" Don't give up!"],
["...and you go again"], 
["make them laugh!"]
]

var gameController : GameController

func enter():
	gameController = get_tree().get_first_node_in_group("gameController") as GameController
	await levelController.playerCreated
	if !gameController.firstTimePlaying:
		var choice = continueLine.pick_random() as Array
		spawnDialogue(choice)
		return;
	gameController.firstTimePlaying = false;
	spawnDialogue(lines);
	gameController.hudNode.visible = false;

func spawnDialogue(lines):
	DialogManager.startDialogue(player.global_position - Vector2(0, -10), lines)
	DialogManager.finished_text_showing.connect(_on_finished_text_showing)
	
func update(delta):
	pass;

func physics_update(delta):
	pass;

func _on_finished_text_showing():
	player.dialog_finished.emit();
	gameController.hudNode.visible = true;
	Transitioned.emit(self, "waves");
