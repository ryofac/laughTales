extends LevelState;

var lines: Array[String] = ["Welcome to the laughtLand!, try to press 'z' ",
"you got the feeling...", 
"a bunch of dark creatures are trying to DESTROY this land...",
"use your JOY to destroy them!",
"now make them laught!",
"destroy at least 10 of them!"]

func enter():
	await levelController.playerCreated
	DialogManager.startDialogue(player.global_position - Vector2(0, -10), lines)
	DialogManager.finished_text_showing.connect(_on_finished_text_showing)
	
func update(delta):
	pass;

func physics_update(delta):
	pass;

func _on_finished_text_showing():
	player.dialog_finished.emit();
	Transitioned.emit(self, "waves");
