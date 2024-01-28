extends Label


# Called when the node enters the scene tree for the first time.
var angle = 0;

func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	angle += 1;
	if angle >= 360:
		angle = 0;

func wave(lenght, speed):
	global_position += sin(angle + speed) * lenght
	
