extends CanvasLayer

@onready var gameController = get_parent() as GameController
var timeToContinue = 3;
var canContinue = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	$Fail.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Control/Title.visible = sin(delta) > 0;
	if timeToContinue <= 0:
		$Control/Warn.visible = true;
		canContinue = true;
	else:
		timeToContinue -= delta;
		
